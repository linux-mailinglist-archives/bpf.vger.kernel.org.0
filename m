Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C295A63895A
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 13:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiKYMGn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 07:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYMGm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 07:06:42 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106503D90F
        for <bpf@vger.kernel.org>; Fri, 25 Nov 2022 04:06:41 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3704852322fso39532997b3.8
        for <bpf@vger.kernel.org>; Fri, 25 Nov 2022 04:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VetN4YvI3iczcELkLHOacZulLcOMQt2TxQbtKxcu1U=;
        b=Nt43aYuJzcJvyiEVSq2jsQsM9YMpuC+95k0oHygdGMAJFYcwtsyWAtouN7sOIxSA/l
         KnWaZXw6EfixLlzPA6EhmFcX/Xn+rpvC8wCPUTOi62s1OynaWuzb1ToBoJreI0mqK6QP
         E274OeaxBx4O+ZyvIxGegb45LKZDJePrB72WkgJQM2Um05TRNZQsz3qFrQcKA3oGcxxT
         hZwLljS3qdBqWyUYkscwCT//tPpP9wdWslLQ66/KEXpQqUJPYlsVv8SEIEbOOzBk4zEd
         0SLG1gae1JQlNWPnhFC9p7PV6KlQX8c6ITOyR9K3Maljur4VUPtzz1LXNbasdLvergJw
         inJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9VetN4YvI3iczcELkLHOacZulLcOMQt2TxQbtKxcu1U=;
        b=lkiWbu6lppaUFREyxxk2TvN7oVtrfgJVBIhgpxAZCai8ceoWwLU/IgYDf1tri1UCm+
         mnz8JILoacguvHK695nYT3oH0KG/ExGLipB2kqH4kSY8+CVBZWoOduJG66MekHknW2xI
         tKS1XxplL/FIzP7ysRQCzR9uP7J6dS3is1qOlaJhLPHUW4YaZTGo1PIqzBFGS/rGJhfj
         Uf3uOZIkCKUbsC5hDvW9ClDAO4c6GETBFkbv0cXUqTZZogD+1a4MjRU7DSdZe1/PnkQ9
         UGtb8ikCH5RIBCrH1nLGxui/NwiWo7aWoFt0KJQgWYyausxUjghaihtGjYRXKAnoyraf
         dyyw==
X-Gm-Message-State: ANoB5pnyZE8F397AZzzIaBDIf1Dp73n+AaKKAf2sa5g64oD0oLIexsQg
        sa6PxDU9SC/If5mazND6NfRmLL/UEW39WbWdabZJ+MGzNlMy5nh2
X-Google-Smtp-Source: AA0mqf4HW0Jex3WM1CiB8/K5HTGOf11nf16uCjzCN0qidF2srpz8EKhHuHT9nP7MY+FY2UWwAS24uJ3eqd4xLgJT4GA=
X-Received: by 2002:a05:690c:91:b0:392:1434:c329 with SMTP id
 be17-20020a05690c009100b003921434c329mr18620185ywb.72.1669377999962; Fri, 25
 Nov 2022 04:06:39 -0800 (PST)
MIME-Version: 1.0
Reply-To: tjcw@cantab.net
From:   Chris Ward <tjcw01@gmail.com>
Date:   Fri, 25 Nov 2022 12:06:29 +0000
Message-ID: <CAC=wTOiGHC-j9AFetOtd9j_8ZD6CwYDN_741tyx31nNrzuku_w@mail.gmail.com>
Subject: First packet going missing in a bpf-examples test case
To:     bpf@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000af6c5a05ee4a5afb"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--000000000000af6c5a05ee4a5afb
Content-Type: text/plain; charset="UTF-8"

I have a new test case for bpf-examples here
https://github.com/tjcw/bpf-examples/tree/tjcw-integration-0.3/AF_XDP-filter
. It is for filtering flows; the idea is to send the first packet of a
flow to userspace, have the userspace determine (by looking at the
fivetuple of the packet) whether the flow is acceptable or not, and
setting an entry in an eBPF map accordingly. Second and subsequent
packets of the flow are handled in kernel by eBPF code.
The test case works, except that the first packet (which is reinjected
to the kernel through a run/tap interface) is then dropped by the
kernel as a 'martian'. The effect is that if you try 'ping' to this
code then you see all packets replied to except the first, and if you
try 'ssh' there is a small hiatus at the start while the TCP protocol
on the client times out and retransmits the SYN packet.

I am attaching the output of 'pwru' (cilium packet-where-are-you) when running
tjcw@tjcw-Standard-PC-Q35-ICH9-2009:~$ ping -c 2 192.168.122.48
PING 192.168.122.48 (192.168.122.48) 56(84) bytes of data.
64 bytes from 192.168.122.48: icmp_seq=2 ttl=64 time=2.28 ms

--- 192.168.122.48 ping statistics ---
2 packets transmitted, 1 received, 50% packet loss, time 1028ms
rtt min/avg/max/mdev = 2.282/2.282/2.282/0.000 ms
tjcw@tjcw-Standard-PC-Q35-ICH9-2009:~$

Does anyone reading this mailing list know why the kernel is treating
the packet as a martian, and if there is a way of overcoming this ? I
am using Ubuntu 22.04 with uname -a showing

tjcw@tjcw-Standard-PC-Q35-ICH9-2009:~$ uname -a
Linux tjcw-Standard-PC-Q35-ICH9-2009 5.15.0-53-generic #59-Ubuntu SMP
Mon Oct 17 18:53:30 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
tjcw@tjcw-Standard-PC-Q35-ICH9-2009:~$

--000000000000af6c5a05ee4a5afb
Content-Type: text/x-log; charset="US-ASCII"; name="pwru.log"
Content-Disposition: attachment; filename="pwru.log"
Content-Transfer-Encoding: base64
Content-ID: <f_lawgfslr0>
X-Attachment-Id: f_lawgfslr0

MjAyMi8xMS8yNSAxMTozNzowMiBMaXN0ZW5pbmcgZm9yIGV2ZW50cy4uCiAgICAgICAgICAgICAg
IFNLQiAgICBDUFUgICAgICAgICAgUFJPQ0VTUyAgICAgICAgICAgICAgICAgICAgIEZVTkMKMHhm
ZmZmOTQ3OGY1MDM4MzAwICAgICAgMSAgICAgICAgWzxlbXB0eT5dICAgICAgICAgcHNrYl9leHBh
bmRfaGVhZAoweGZmZmY5NDc4ZjUwMzgzMDAgICAgICAxICAgICAgICBbPGVtcHR5Pl0gICAgICAg
ICAgICBza2JfZnJlZV9oZWFkCjB4ZmZmZjk0NzhmNTAzODMwMCAgICAgIDEgICAgICAgIFs8ZW1w
dHk+XSBicGZfcHJvZ19ydW5fZ2VuZXJpY194ZHAKMHhmZmZmOTQ3OGY1MDM4MzAwICAgICAgMSAg
ICAgICAgWzxlbXB0eT5dICB4ZHBfZG9fZ2VuZXJpY19yZWRpcmVjdAoweGZmZmY5NDc4ZjUwMzgz
MDAgICAgICAxICAgICAgICBbPGVtcHR5Pl0gICAgICAgICAgICAgIGNvbnN1bWVfc2tiCjB4ZmZm
Zjk0NzhmNTAzODMwMCAgICAgIDEgICAgICAgIFs8ZW1wdHk+XSAgIHNrYl9yZWxlYXNlX2hlYWRf
c3RhdGUKMHhmZmZmOTQ3OGY1MDM4MzAwICAgICAgMSAgICAgICAgWzxlbXB0eT5dICAgICAgICAg
c2tiX3JlbGVhc2VfZGF0YQoweGZmZmY5NDc4ZjUwMzgzMDAgICAgICAxICAgICAgICBbPGVtcHR5
Pl0gICAgICAgICAgICBza2JfZnJlZV9oZWFkCjB4ZmZmZjk0NzhmNTAzODMwMCAgICAgIDEgICAg
ICAgIFs8ZW1wdHk+XSAgICAgICAgICAgICBrZnJlZV9za2JtZW0KMHhmZmZmOTQ3OGY1MDM4MzAw
ICAgICAgMSAgICBbYWZfeGRwX3VzZXJdICAgICAgICBuZXRpZl9yZWNlaXZlX3NrYgoweGZmZmY5
NDc4ZjUwMzgzMDAgICAgICAxICAgIFthZl94ZHBfdXNlcl0gICBza2JfZGVmZXJfcnhfdGltZXN0
YW1wCjB4ZmZmZjk0NzhmNTAzODMwMCAgICAgIDEgICAgW2FmX3hkcF91c2VyXSAgICAgIF9fbmV0
aWZfcmVjZWl2ZV9za2IKMHhmZmZmOTQ3OGY1MDM4MzAwICAgICAgMSAgICBbYWZfeGRwX3VzZXJd
IF9fbmV0aWZfcmVjZWl2ZV9za2Jfb25lX2NvcmUKMHhmZmZmOTQ3OGY1MDM4MzAwICAgICAgMSAg
ICBbYWZfeGRwX3VzZXJdICAgICAgICAgICAgICAgICAgIGlwX3JjdgoweGZmZmY5NDc4ZjUwMzgz
MDAgICAgICAxICAgIFthZl94ZHBfdXNlcl0gICAgICAgICAgICAgIGlwX3Jjdl9jb3JlCjB4ZmZm
Zjk0NzhmNTAzODMwMCAgICAgIDEgICAgW2FmX3hkcF91c2VyXSAgICAgICAgICAgICAgIHNvY2tf
d2ZyZWUKMHhmZmZmOTQ3OGY1MDM4MzAwICAgICAgMSAgICBbYWZfeGRwX3VzZXJdICAgICBpcF9y
b3V0ZV9pbnB1dF9ub3JlZgoweGZmZmY5NDc4ZjUwMzgzMDAgICAgICAxICAgIFthZl94ZHBfdXNl
cl0gICAgICAgaXBfcm91dGVfaW5wdXRfcmN1CjB4ZmZmZjk0NzhmNTAzODMwMCAgICAgIDEgICAg
W2FmX3hkcF91c2VyXSAgICAgIGlwX3JvdXRlX2lucHV0X3Nsb3cKMHhmZmZmOTQ3OGY1MDM4MzAw
ICAgICAgMSAgICBbYWZfeGRwX3VzZXJdICAgICAgZmliX3ZhbGlkYXRlX3NvdXJjZQoweGZmZmY5
NDc4ZjUwMzgzMDAgICAgICAxICAgIFthZl94ZHBfdXNlcl0gICAgX19maWJfdmFsaWRhdGVfc291
cmNlCjB4ZmZmZjk0NzhmNTAzODMwMCAgICAgIDEgICAgW2FmX3hkcF91c2VyXSBpcF9oYW5kbGVf
bWFydGlhbl9zb3VyY2UKMHhmZmZmOTQ3OGY1MDM4MzAwICAgICAgMSAgICBbYWZfeGRwX3VzZXJd
ICAgICAgICAga2ZyZWVfc2tiX3JlYXNvbgoweGZmZmY5NDc4ZjUwMzgzMDAgICAgICAxICAgIFth
Zl94ZHBfdXNlcl0gICBza2JfcmVsZWFzZV9oZWFkX3N0YXRlCjB4ZmZmZjk0NzhmNTAzODMwMCAg
ICAgIDEgICAgW2FmX3hkcF91c2VyXSAgICAgICAgIHNrYl9yZWxlYXNlX2RhdGEKMHhmZmZmOTQ3
OGY1MDM4MzAwICAgICAgMSAgICBbYWZfeGRwX3VzZXJdICAgICAgICAgICAgc2tiX2ZyZWVfaGVh
ZAoweGZmZmY5NDc4ZjUwMzgzMDAgICAgICAxICAgIFthZl94ZHBfdXNlcl0gICAgICAgICAgICAg
a2ZyZWVfc2tibWVtCjB4ZmZmZjk0NzhjNzVkMzAwMCAgICAgIDEgICAgICAgIFs8ZW1wdHk+XSAg
ICAgICAgIHBza2JfZXhwYW5kX2hlYWQKMHhmZmZmOTQ3OGM3NWQzMDAwICAgICAgMSAgICAgICAg
WzxlbXB0eT5dICAgICAgICAgICAgc2tiX2ZyZWVfaGVhZAoweGZmZmY5NDc4Yzc1ZDMwMDAgICAg
ICAxICAgICAgICBbPGVtcHR5Pl0gYnBmX3Byb2dfcnVuX2dlbmVyaWNfeGRwCjB4ZmZmZjk0Nzhj
NzVkMzAwMCAgICAgIDEgICAgICAgIFs8ZW1wdHk+XSAgICAgICAgICAgICAgICAgICBpcF9yY3YK
MHhmZmZmOTQ3OGM3NWQzMDAwICAgICAgMSAgICAgICAgWzxlbXB0eT5dICAgICAgICAgICAgICBp
cF9yY3ZfY29yZQoweGZmZmY5NDc4Yzc1ZDMwMDAgICAgICAxICAgICAgICBbPGVtcHR5Pl0gICAg
ICAgICAgICAgICAgc2tiX2Nsb25lCjB4ZmZmZjk0NzhjNzVkMzAwMCAgICAgIDEgICAgICAgIFs8
ZW1wdHk+XSAgICAgICAgICAgICAgY29uc3VtZV9za2IKMHhmZmZmOTQ3OGY1MDM4YzAwICAgICAg
MSAgICAgICAgWzxlbXB0eT5dICAgICBpcF9yb3V0ZV9pbnB1dF9ub3JlZgoweGZmZmY5NDc4ZjUw
MzhjMDAgICAgICAxICAgICAgICBbPGVtcHR5Pl0gICAgICAgaXBfcm91dGVfaW5wdXRfcmN1CjB4
ZmZmZjk0NzhmNTAzOGMwMCAgICAgIDEgICAgICAgIFs8ZW1wdHk+XSAgICAgIGlwX3JvdXRlX2lu
cHV0X3Nsb3cKMHhmZmZmOTQ3OGY1MDM4YzAwICAgICAgMSAgICAgICAgWzxlbXB0eT5dICAgICAg
ZmliX3ZhbGlkYXRlX3NvdXJjZQoweGZmZmY5NDc4ZjUwMzhjMDAgICAgICAxICAgICAgICBbPGVt
cHR5Pl0gICAgX19maWJfdmFsaWRhdGVfc291cmNlCjB4ZmZmZjk0NzhmNTAzOGMwMCAgICAgIDEg
ICAgICAgIFs8ZW1wdHk+XSAgICAgICAgIGlwX2xvY2FsX2RlbGl2ZXIKMHhmZmZmOTQ3OGY1MDM4
YzAwICAgICAgMSAgICAgICAgWzxlbXB0eT5dICBpcF9sb2NhbF9kZWxpdmVyX2ZpbmlzaAoweGZm
ZmY5NDc4ZjUwMzhjMDAgICAgICAxICAgICAgICBbPGVtcHR5Pl0gIGlwX3Byb3RvY29sX2RlbGl2
ZXJfcmN1CjB4ZmZmZjk0NzhmNTAzOGMwMCAgICAgIDEgICAgICAgIFs8ZW1wdHk+XSAgICAgICAg
cmF3X2xvY2FsX2RlbGl2ZXIKMHhmZmZmOTQ3OGY1MDM4YzAwICAgICAgMSAgICAgICAgWzxlbXB0
eT5dICAgICAgICAgICAgICAgICBpY21wX3JjdgoweGZmZmY5NDc4ZjUwMzhjMDAgICAgICAxICAg
ICAgICBbPGVtcHR5Pl0gIF9fc2tiX2NoZWNrc3VtX2NvbXBsZXRlCjB4ZmZmZjk0NzhmNTAzOGMw
MCAgICAgIDEgICAgICAgIFs8ZW1wdHk+XSAgICAgICAgICAgICAgICBpY21wX2VjaG8KMHhmZmZm
OTQ3OGY1MDM4YzAwICAgICAgMSAgICAgICAgWzxlbXB0eT5dICAgICAgICAgICAgICAgaWNtcF9y
ZXBseQoweGZmZmY5NDc4ZjUwMzhjMDAgICAgICAxICAgICAgICBbPGVtcHR5Pl0gICAgICAgIF9f
aXBfb3B0aW9uc19lY2hvCjB4ZmZmZjk0NzhmNTAzOGMwMCAgICAgIDEgICAgICAgIFs8ZW1wdHk+
XSAgICAgZmliX2NvbXB1dGVfc3BlY19kc3QKMHhmZmZmOTQ3OGY1MDM4YzAwICAgICAgMSAgICAg
ICAgWzxlbXB0eT5dIHNlY3VyaXR5X3NrYl9jbGFzc2lmeV9mbG93CjB4ZmZmZjk0NzhmNTAzOGMw
MCAgICAgIDEgICAgICAgIFs8ZW1wdHk+XSAgICAgICAgICAgICAgY29uc3VtZV9za2IKMHhmZmZm
OTQ3OGY1MDM4YzAwICAgICAgMSAgICAgICAgWzxlbXB0eT5dICAgc2tiX3JlbGVhc2VfaGVhZF9z
dGF0ZQoweGZmZmY5NDc4ZjUwMzhjMDAgICAgICAxICAgICAgICBbPGVtcHR5Pl0gICAgICAgICBz
a2JfcmVsZWFzZV9kYXRhCjB4ZmZmZjk0NzhmNTAzOGMwMCAgICAgIDEgICAgICAgIFs8ZW1wdHk+
XSAgICAgICAgICAgICBrZnJlZV9za2JtZW0KMHhmZmZmOTQ3OGM3NWQzMDAwICAgICAgMSAgICAg
ICAgWzxlbXB0eT5dICAgICAgICAgICAgICAgcGFja2V0X3JjdgoweGZmZmY5NDc4Yzc1ZDMwMDAg
ICAgICAxICAgICAgICBbPGVtcHR5Pl0gICAgICAgICAgICAgIGNvbnN1bWVfc2tiCjB4ZmZmZjk0
NzhjNzVkMzAwMCAgICAgIDEgICAgICAgIFs8ZW1wdHk+XSAgIHNrYl9yZWxlYXNlX2hlYWRfc3Rh
dGUKMHhmZmZmOTQ3OGM3NWQzMDAwICAgICAgMSAgICAgICAgWzxlbXB0eT5dICAgICAgICAgc2ti
X3JlbGVhc2VfZGF0YQoweGZmZmY5NDc4Yzc1ZDMwMDAgICAgICAxICAgICAgICBbPGVtcHR5Pl0g
ICAgICAgICAgICBza2JfZnJlZV9oZWFkCg==
--000000000000af6c5a05ee4a5afb--
