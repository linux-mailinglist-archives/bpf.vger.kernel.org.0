Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C271C19EC
	for <lists+bpf@lfdr.de>; Fri,  1 May 2020 17:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgEAPlz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 May 2020 11:41:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28108 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729803AbgEAPlz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 1 May 2020 11:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588347713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3+V+1b4xErxaDJo1CYF6OtSxf4BoUjOPu7wBy9Hn3M4=;
        b=SIDCv9jGx+qo1mOAdJoLc8YwAORKwPhbhi/glUJfQHUDZdStjAdwGYVIGz1JTjwQV2Je7l
        dL57/nGvOisBZDFq3C45DGXsOKnc351yP2Yi4K02IYEF4iZWRRQf8gdy3eKpbDHts1KU6e
        prI7LUdG3FtywF/DtYrHEDOX65godK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-qijVZo4NMsak8_Y2PxtWZw-1; Fri, 01 May 2020 11:41:46 -0400
X-MC-Unique: qijVZo4NMsak8_Y2PxtWZw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F4FA107ACCA;
        Fri,  1 May 2020 15:41:45 +0000 (UTC)
Received: from carbon (unknown [10.40.208.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88D8B1002382;
        Fri,  1 May 2020 15:41:34 +0000 (UTC)
Date:   Fri, 1 May 2020 17:41:32 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     brouer@redhat.com, BPF-dev-list <bpf@vger.kernel.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
        Matteo Croce <mcroce@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Fighting BPF verifier to reach end-of-packet with XDP
Message-ID: <20200501174132.4388983e@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

One use-case for tail grow patchset, is to add a kernel timestamp at
XDP time in the extended tailroom of packet and return XDP_PASS to let
packet travel were it needs to go, and then via tcpdump we can extract
this timestamp. (E.g. this could improve on Ilias TSN measurements[2]).

I have implemented it here[3]. It works, but it is really a hassle to
convince the BPF verifier, that my program was safe.  I use the
IP-headers total length to find the end-of-packet.

Is there an easier BPF way to move a data pointer to data_end?

Any suggestion on how I could extend the kernel (or verifier) to
provide easier access to the tailroom I grow?


[3] https://github.com/xdp-project/xdp-tutorial/blob/tailgrow01.public/packet04-tailgrow/xdp_prog_kern.c#L97-L115
[1] https://patchwork.ozlabs.org/project/netdev/list/?series=173782&state=%2A&archive=both
[2] https://github.com/xdp-project/xdp-project/blob/master/areas/arm64/xdp_for_tsn.org

- - 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

Relevant code copy-pasted below, to make it easier to email comment:

SEC("xdp_tailgrow_parse")
int grow_parse(struct xdp_md *ctx)
{
	void *data_end;
	void *data;
	int action = XDP_PASS;
	int eth_type, ip_type;
	struct hdr_cursor nh;
	struct iphdr *iphdr;
	struct ethhdr *eth;
	__u16 ip_tot_len;

	struct my_timestamp *ts;

	/* Increase packet size (at tail) and reload data pointers */
	__u8 offset = sizeof(*ts);
	if (bpf_xdp_adjust_tail(ctx, offset))
		goto out;
	data_end = (void *)(long)ctx->data_end;
	data = (void *)(long)ctx->data;

	/* These keep track of the next header type and iterator pointer */
	nh.pos = data;

	eth_type = parse_ethhdr(&nh, data_end, &eth);
	if (eth_type < 0) {
		action = XDP_ABORTED;
		goto out;
	}

	if (eth_type == bpf_htons(ETH_P_IP)) {
		ip_type = parse_iphdr(&nh, data_end, &iphdr);
	} else {
		action = XDP_PASS;
		goto out;
	}

	/* Demo use-case: Add timestamp in extended tailroom to ICMP packets,
	 * before sending to network-stack via XDP_PASS.  This can be
	 * captured via tcpdump, and provide earlier (XDP layer) timestamp.
	 */
	if (ip_type == IPPROTO_ICMP) {

		/* Packet size in bytes, including IP header and data */
		ip_tot_len = bpf_ntohs(iphdr->tot_len);

		/*
		 * Tricks to get pass the verifier. Being allowed to use
		 * packet value iphdr->tot_len, involves bounding possible
		 * values to please verifier.
		 */
		if (ip_tot_len < 2) {
			/* This check seems strange on unsigned ip_tot_len,
			 * but is needed, else verifier complains:
			 * "unbounded min value is not allowed"
			 */
			goto out;
		}
		ip_tot_len &= 0xFFF; /* Max 4095 */

		/* Finding end of packet + offset, and bound access */
		if ((void *)iphdr + ip_tot_len + offset > data_end) {
			action = XDP_ABORTED;
			goto out;
		}

		/* Point ts to end-of-packet, that have been offset extended */
		ts = (void *)iphdr + ip_tot_len;
		ts->magic = 0x5354; /* String "TS" in network-byte-order */
		ts->time  = bpf_ktime_get_ns();
	}
out:
	return xdp_stats_record_action(ctx, action);
}

