Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD48181D11
	for <lists+bpf@lfdr.de>; Wed, 11 Mar 2020 16:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbgCKP6g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 11 Mar 2020 11:58:36 -0400
Received: from postout1.mail.lrz.de ([129.187.255.137]:37065 "EHLO
        postout1.mail.lrz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbgCKP6g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Mar 2020 11:58:36 -0400
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
        by postout1.mail.lrz.de (Postfix) with ESMTP id 48cxT57048zyS6
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2020 16:58:33 +0100 (CET)
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -0.585
X-Spam-Level: 
X-Spam-Status: No, score=-0.585 tagged_above=-999 required=5
        tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, LRZ_CT_PLAIN_ISO8859_1=0.001,
        LRZ_DATE_TZ_0000=0.001, LRZ_DKIM_DESTROY_MTA=0.001,
        LRZ_DMARC_OVERWRITE=0.001, LRZ_ENVFROM_FROM_ALIGNED_STRICT=0.001,
        LRZ_ENVFROM_FROM_MATCH=0.001, LRZ_FROM_AP_PHRASE=0.001,
        LRZ_FROM_HAS_A=0.001, LRZ_FROM_HAS_MDOM=0.001, LRZ_FROM_HAS_MX=0.001,
        LRZ_FROM_HOSTED_DOMAIN=0.001, LRZ_FROM_NAME_IN_ADDR=0.001,
        LRZ_FROM_PHRASE=0.001, LRZ_FWD_MS_EX=0.001, LRZ_HAS_CLANG=0.001,
        LRZ_HAS_THREAD_INDEX=0.001, LRZ_HAS_URL_HTTP=0.001,
        LRZ_HAS_X_ORIG_IP=0.001, LRZ_MSGID_HL32=0.001,
        LRZ_RCVD_BADWLRZ_EXCH=0.001, LRZ_RCVD_MS_EX=0.001, LRZ_RDNS_NONE=1.5,
        RDNS_NONE=0.793, SPF_HELO_NONE=0.001] autolearn=no autolearn_force=no
Received: from postout1.mail.lrz.de ([127.0.0.1])
        by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
        with LMTP id fL8_aa3vDtXp for <bpf@vger.kernel.org>;
        Wed, 11 Mar 2020 16:58:33 +0100 (CET)
Received: from BADWLRZ-SWMBX03.ads.mwn.de (BADWLRZ-SWMBX03.ads.mwn.de [IPv6:2001:4ca0:0:108::159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "BADWLRZ-SWMBX03", Issuer "BADWLRZ-SWMBX03" (not verified))
        by postout1.mail.lrz.de (Postfix) with ESMTPS id 48cxT55195zyZl
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2020 16:58:33 +0100 (CET)
Received: from BADWLRZ-SWMBX03.ads.mwn.de (2001:4ca0:0:108::159) by
 BADWLRZ-SWMBX03.ads.mwn.de (2001:4ca0:0:108::159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 11 Mar 2020 16:58:33 +0100
Received: from BADWLRZ-SWMBX03.ads.mwn.de ([fe80::b83a:fd44:92bb:7e5e]) by
 BADWLRZ-SWMBX03.ads.mwn.de ([fe80::b83a:fd44:92bb:7e5e%13]) with mapi id
 15.01.1913.007; Wed, 11 Mar 2020 16:58:33 +0100
From:   "Gaul, Maximilian" <maximilian.gaul@hm.edu>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Shared Umem between processes
Thread-Topic: Shared Umem between processes
Thread-Index: AQHV973HYXLoSjdqpUaKyJTfUanHqA==
Date:   Wed, 11 Mar 2020 15:58:33 +0000
Message-ID: <fd5e40efd5c1426cb4a5942682407ea2@hm.edu>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Exchange-Organization-AuthAs: Internal
X-MS-Exchange-Organization-AuthMechanism: 04
X-MS-Exchange-Organization-AuthSource: BADWLRZ-SWMBX03.ads.mwn.de
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [80.246.32.33]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello everyone,


I am not sure if this is the correct address for my question / problem but I was forwarded to this e-mail from the libbpf github-issue section, so this is my excuse.


Just a few information at the start of this e-mail: My program is largely based on: https://github.com/xdp-project/xdp-tutorial/tree/master/advanced03-AF_XDP and I am using libbpf: https://github.com/libbpf/libbpf


I am currently trying to build an application that enables me to process multiple udp-multicast streams at once in parallel (each with up to several ten-thousands of packets per second).


My first solution was to steer each multicast-stream on a separate RX-Queue on my NIC via `ethtool -N <if> flow-type udp4 ...` and to spawn as much user-space processes (each with a separate AF-XDP socket connected to one of the RX-Queues) as there are streams to process.


But because this solution is limited to the amount of RX-Queues the NIC has and I wanted to build something hardware-independent, I looked around a bit and found a feature called `XDP_SHARED_UMEM`.



As far as I understand (please correct me if I am wrong), at the moment libbpf only supports shared umem between threads of a process but not between processes - right?

I ran unto the problem, that `struct xsk_umem` is hidden in `xsk.c`. This prevents me from copying the content from the original socket / umem into shared memory. I am not sure, what information the sub-process (the one which is using the umem from another process) needs so I figured the simplest solution would be to just copy the whole umem struct.



So I went with the "quick-fix" to just move the definition of `struct xsk_umem` into `xsk.h` and to copy the umem-information from the original process into a shared memory. This process then calls `fork()` thus spawning a sub-process. This sub-process then reads the previously written umem-information from shared memory and passes it into `xsk_configure_socket` (af_xdp_user.c) which then eventually calls `xsk_socket__create` in `xsk.c`. This function then checks for `umem->refcount` and sets the flags for shared umem accordingly.



After returning from `xsk_socket__create` (we are still in `xsk_configure_socket` in af_xdp_user.c), `bpf_get_link_xdp_id` is called (I don't know if that's necessary). But after that call I exit the function `xsk_socket__create` in the sub-process because I figured it is probably bad to configure the umem a second time by calling `xsk_ring_prod__reserve` after that:




static struct xsk_socket_info *xsk_configure_socket(struct config *cfg, struct xsk_umem_info *umem) {

struct xsk_socket_config xsk_cfg;
struct xsk_socket_info *xsk_info;
uint32_t idx;
uint32_t prog_id = 0;
int i;
int ret;

xsk_info = calloc(1, sizeof(*xsk_info));
if (!xsk_info)
return NULL;

xsk_info->umem = umem;
xsk_cfg.rx_size = XSK_RING_CONS__DEFAULT_NUM_DESCS;
xsk_cfg.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
xsk_cfg.libbpf_flags = 0;
xsk_cfg.xdp_flags = cfg->xdp_flags;
xsk_cfg.bind_flags = cfg->xsk_bind_flags;
ret = xsk_socket__create(&xsk_info->xsk, cfg->ifname, cfg->xsk_if_queue, umem->umem, &xsk_info->rx, &xsk_info->tx, &xsk_cfg);

if (ret) {
fprintf(stderr, "FAIL 1\n");
goto error_exit;
}

ret = bpf_get_link_xdp_id(cfg->ifindex, &prog_id, cfg->xdp_flags);
if (ret) {
fprintf(stderr, "FAIL 2\n");
goto error_exit;
}

/* Initialize umem frame allocation */
for (i = 0; i < NUM_FRAMES; i++)
xsk_info->umem_frame_addr[i] = i * FRAME_SIZE;

xsk_info->umem_frame_free = NUM_FRAMES;

if(cfg->use_shrd_umem) {
return xsk_info;
}
        ...
}

Somehow what I am doing doesn't work because my sub-process dies in `xsk_configure_socket`. I am not able to debug it properly with GDB though. Another point I don't understand is the statement:

However, note that you need to supply the XSK_LIBBPF_FLAGS__INHIBIT_PROG_LOAD libbpf_flag with the xsk_socket__create calls and load your own XDP program as there is no built in one in libbpf that will route the traffic for you.

from https://www.kernel.org/doc/html/latest/networking/af_xdp.html#xdp-shared-umem-bind-flag

I didn't know that libbpf loads a XDP-program? Why would it do that? I am using my own af-xdp program which filters for udp-packets. If I set `xsk_cfg.libbpf_flags = XSK_LIBBPF_FLAGS__INHIBIT_PROG_LOAD;` in `xsk_configure_socket`, the af-xdp-socket fd is not put into the kernel `xsks-map` which basically means that I don't receive any packets.

As you probably already noticed, I am overstrained with the concept of Shared Umem and I have to say, there is no documentation about it besides the two sentences in https://www.kernel.org/doc/html/latest/networking/af_xdp.html#xdp-shared-umem-bind-flag and a mail in a linux mailbox from Nov. 2019 stating that this feature is now implemented.

Can you please help?

Best regards

Max
