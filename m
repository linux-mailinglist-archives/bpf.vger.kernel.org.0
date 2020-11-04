Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38512A6C73
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 19:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgKDSIT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 13:08:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729883AbgKDSIS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 13:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604513297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xlVyIMj+D4C0ZjIheXkr79wdXwzVXbnqV1PApwQPET0=;
        b=W0wXLW0QX0DRevLtXLdE7Pb81yDhE4rj+VzGKHRr0OhbLh6i24GeyFiz7sKfBD/6DWpmcv
        mShzQvDICZBzyWNTnp9iGM8j9n+jV7gPh3+aItX3DAu6ESmkRVHBAn+dohrAo9gdYuAiMP
        pdWq4dId08ZM2jfxrFpTvpYw2A2/ayQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-dY3dCW71OnCs-Tztt5j-EQ-1; Wed, 04 Nov 2020 13:08:13 -0500
X-MC-Unique: dY3dCW71OnCs-Tztt5j-EQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16D7D8014C1;
        Wed,  4 Nov 2020 18:08:12 +0000 (UTC)
Received: from localhost (unknown [10.40.194.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FEF6756A6;
        Wed,  4 Nov 2020 18:08:10 +0000 (UTC)
Date:   Wed, 4 Nov 2020 19:08:08 +0100
From:   Jiri Benc <jbenc@redhat.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, sdf@google.com,
        jakub@cloudflare.com, john.fastabend@gmail.com,
        kernel-team@cloudflare.com, bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/6] bpf: flow_dissector: check value of unused
 flags to BPF_PROG_ATTACH
Message-ID: <20201104190808.417b9a4b@redhat.com>
In-Reply-To: <20200629095630.7933-2-lmb@cloudflare.com>
References: <20200629095630.7933-1-lmb@cloudflare.com>
        <20200629095630.7933-2-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 29 Jun 2020 10:56:25 +0100, Lorenz Bauer wrote:
> Using BPF_PROG_ATTACH on a flow dissector program supports neither
> target_fd, attach_flags or replace_bpf_fd but accepts any value.
> 
> Enforce that all of them are zero. This is fine for replace_bpf_fd
> since its presence is indicated by BPF_F_REPLACE. It's more
> problematic for target_fd, since zero is a valid fd. Should we
> want to use the flag later on we'd have to add an exception for
> fd 0. The alternative is to force a value like -1. This requires
> more changes to tests. There is also precedent for using 0,
> since bpf_iter uses this for target_fd as well.
> 
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> Fixes: b27f7bb590ba ("flow_dissector: Move out netns_bpf prog callbacks")
> ---
>  kernel/bpf/net_namespace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
> index 3e89c7ad42cb..bf18eabeaea2 100644
> --- a/kernel/bpf/net_namespace.c
> +++ b/kernel/bpf/net_namespace.c
> @@ -217,6 +217,9 @@ int netns_bpf_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>  	struct net *net;
>  	int ret;
>  
> +	if (attr->target_fd || attr->attach_flags || attr->replace_bpf_fd)
> +		return -EINVAL;

I'm debugging failing test_flow_dissector.sh selftest and I wonder how
this patch works.

The test_flow_dissector.sh selftest at line 28 runs:

bpftool prog -d attach pinned /sys/fs/bpf/flow/flow_dissector flow_dissector

which invokes this code:

static int parse_attach_detach_args(int argc, char **argv, int *progfd,
                                    enum bpf_attach_type *attach_type,
                                    int *mapfd)
{
	[...]
        if (*attach_type == BPF_FLOW_DISSECTOR) {
                *mapfd = -1;
                return 0;
        }
	[...]
}

The mapfd is later used as attr->target_fd:

static int do_attach(int argc, char **argv)
{
	[...]
        err = bpf_prog_attach(progfd, mapfd, attach_type, 0);
	[...]
}

and rejected in the kernel by the line added by this patch. Seems that
setting flow dissector using bpftool does not work since this patch was
applied? What am I missing?

 Jiri

