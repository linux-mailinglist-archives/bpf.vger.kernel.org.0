Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC85618ED9
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 04:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiKDDTq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 23:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiKDDSv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 23:18:51 -0400
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B659325EAA;
        Thu,  3 Nov 2022 20:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1667531838;
        bh=xhvqscpJ8eJYk/Q1N9/AJKfFH00gTLPyIzjaSVR0k08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=roa+3ScDD5VMRjXOG53h6XVLuVaoeVDE1Q1GLaMsAjzLxDQR5rSet9QmaRE8x1M6C
         1Y81LScFpVMJ4IMzMpaV7nUx0zNkxYn3IOb2yjwfG2mbkQJjWYnTh6MxLF8GqqbwVa
         AMBRvtK39mUBQxBfSM2nZ9x+UXSE8DdzP2QpaJ+I=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 44E2E01A; Fri, 04 Nov 2022 11:17:14 +0800
X-QQ-mid: xmsmtpt1667531834turi4l2i0
Message-ID: <tencent_6AD8D17AC411037DA1AC2C8FCB0D15A3D707@qq.com>
X-QQ-XMAILINFO: MMlYfvMiV1QnzSU/jATHOmgR8F5vhf1cuFc1zIQTTj922N06YwuoU/DuDKoXx1
         SHs0eXcxKw+hBwtigH33hQbb07gG7y0b++YpCt49bXitNaT7nFbbO5a7x9fLPbpgeZxk49aa8jFl
         SI/IS1Sx+xG1+AUsS3D/h6kjSBgsOzQRltVzqj9NGgmhpmpIe3pWmM1EaJThPWf7Uf4bTNug3xXq
         7tVJxmNdsmolCyoCEyJr8k9CcgTRZ8NPWqvXS9vm88oX5gvZYSSFwsc4gl4C7sbQVb7BCZiOf7as
         inWyJFUHpHQsgDoAnyMmz0VrXSgvOmGvfkeSt5SwmBEAvbL/4NegphtTaHk08RTCnSmuYRnriHzY
         5cKDxZ7J6GDI+XIcz3XNUERdKcx7HiCuKir8bRL1LuKyRHcgusiYn/cWP4AY/OZPJx5VKRCd+PNN
         HCMzqyosXzrXNQeQsLXDGJaq5xihlDXFFiGiULOR5+MdBmL+2mwQ0UYnTo5BIZHhycDH7UQa9Tp/
         g156OjDzTM1lHPm4iEDmloSHg7XqWXjcNJU4UzjZ3xPbF6s06JVICEecCh7drdCt79s6kzAnZT7m
         /gFeMZrTXsg+joirhplELGYXRov1Ct9A3wP5Eqm2pdLkmRJe3xYKDYj6ZB+Ch+cpSalsDEAL+NR+
         YgpnP7BXUQY6dLT50aH+ek3cIgXWnFEtHI55lDEC5We5337OrF3Mma9Uc8tIM+tB/6+4xwfzzTkU
         sP+9mP9RC0fms3wSBlWo/7NRa7+t3XrI+GoLivqxON4EUnJGCtyystj3GEd3okIC4ISoNUqp3Lih
         wUAG8688cKStCBFfRa3o44OD0R1Jmy2qxOLiAvw1HfP6gOAmhJ+NyTLUKI7iWa12AUaWeDV8n8sy
         eUeDedX5N+nyC/oBC39Kh2mKMYu7w/APnO3OlnJXglXJjJEu48/XmCuRuT02SSrKdCBwBAxnAsHM
         NxbbEy6lFA3+m6gh2qsuDc0LrmrfFHlcUX3C3dQYx3PeMS4CHn8sIg8shCBwr1qJd0dLPmDP0=
From:   Rong Tao <rtoax@foxmail.com>
To:     andrii.nakryiko@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, rongtao@cestc.cn, rtoax@foxmail.com,
        sdf@google.com, song@kernel.org, yhs@fb.com
Subject: Re: Re: [PATCH bpf-next] samples/bpf: Fix sockex3: missing BPF prog type
Date:   Fri,  4 Nov 2022 11:17:13 +0800
X-OQ-MSGID: <20221104031713.668305-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <CAEf4BzbvCABmSB3UqKyka=txTiCUdBpTtQg4X6XOa_qVVXW+hw@mail.gmail.com>
References: <CAEf4BzbvCABmSB3UqKyka=txTiCUdBpTtQg4X6XOa_qVVXW+hw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We can not just remove the number of program like:

-#define PROG(F) SEC("socket/"__stringify(F)) int bpf_func_##F
+#define PROG(F) SEC("socket_filter") int bpf_func_##F

because "sockex3" use the _NUMBER_ as index(see map "jmp_table"), if we
apply the following patch, it's still not recognize "socket_filter/xxx"
as "socket_filter", still have "missing BPF prog type" error:

diff --git a/samples/bpf/sockex3_kern.c b/samples/bpf/sockex3_kern.c
index b363503357e5..ab5a7bde66d0 100644
--- a/samples/bpf/sockex3_kern.c
+++ b/samples/bpf/sockex3_kern.c
@@ -17,7 +17,7 @@
 #define IP_MF          0x2000
 #define IP_OFFSET      0x1FFF

-#define PROG(F) SEC("socket/"__stringify(F)) int bpf_func_##F
+#define PROG(F) SEC("socket_filter/"__stringify(F)) int bpf_func_##F

 struct {
        __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
@@ -279,7 +279,7 @@ PROG(PARSE_MPLS)(struct __sk_buff *skb)
        return 0;
 }

-SEC("socket/0")
+SEC("socket_filter/0")
 int main_prog(struct __sk_buff *skb)
 {
        __u32 nhoff = ETH_HLEN;
diff --git a/samples/bpf/sockex3_user.c b/samples/bpf/sockex3_user.c
index cd6fa79df900..63fc9a8077b1 100644
--- a/samples/bpf/sockex3_user.c
+++ b/samples/bpf/sockex3_user.c
@@ -56,7 +56,7 @@ int main(int argc, char **argv)
                fd = bpf_program__fd(prog);

                section = bpf_program__section_name(prog);
-               if (sscanf(section, "socket/%d", &key) != 1) {
+               if (sscanf(section, "socket_filter/%d", &key) != 1) {
                        fprintf(stderr, "ERROR: finding prog failed\n");
                        goto cleanup;
                }

For a reason, in sockex3_kern.c only have five PROGs, list all five:

#define PROG(F) SEC("socket/"__stringify(F)) int bpf_func_##F
PROG(PARSE_IP)(struct __sk_buff *skb)
PROG(PARSE_IPV6)(struct __sk_buff *skb)
PROG(PARSE_VLAN)(struct __sk_buff *skb)
PROG(PARSE_MPLS)(struct __sk_buff *skb)
SEC("socket/0") int main_prog(struct __sk_buff *skb)

As you can see, all those PROGs are BPF_PROG_TYPE_SOCKET_FILTER, so we can
use the follow patch specify bpf program type as SOCKET_FILTER:

https://lore.kernel.org/lkml/tencent_7DD02046A8398BE3324F85E0F56ED41EB105@qq.com/

diff --git a/samples/bpf/sockex3_user.c b/samples/bpf/sockex3_user.c
index cd6fa79df900..dc79c17ad195 100644
--- a/samples/bpf/sockex3_user.c
+++ b/samples/bpf/sockex3_user.c
@@ -39,6 +39,9 @@ int main(int argc, char **argv)
                return 0;
        }

+       bpf_object__for_each_program(prog, obj)
+               bpf_program__set_type(prog, BPF_PROG_TYPE_SOCKET_FILTER);
+
        /* load BPF program */
        if (bpf_object__load(obj)) {
                fprintf(stderr, "ERROR: loading BPF object file failed\n");

This patch above totally solved the compile error.

