Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C91402241
	for <lists+bpf@lfdr.de>; Tue,  7 Sep 2021 04:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhIGCZk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Sep 2021 22:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhIGCZk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Sep 2021 22:25:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F834C061575
        for <bpf@vger.kernel.org>; Mon,  6 Sep 2021 19:24:34 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t19so16504908lfe.13
        for <bpf@vger.kernel.org>; Mon, 06 Sep 2021 19:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KE04igOM/tFg7wGrex+qvSfHgZMwcZ7hpbE2bEe0+OA=;
        b=aLwWI/HZR5mkzIUCzmRn9dvOcErgZYbyXYBpIw4tzelIvoPplall6F+//OKRaRDRx8
         ytT9Bpwbb97hZJbdcRoYXBkL0JKn3VHqG9eoBgUIlFJWCF49mwLwHkUaPLC7QtU9T75U
         ULaA8xDCwreKAOx74/ZPVnqauDo62MaAHcrKSpqN6QR8L6CgFnLW13xQNHsx6YVoA1GA
         7gxL8b+rQKJzOe5ec66WvBBlQZ/xrwDiZwoGi7NazCe3J6ideoQhRk19SWdtdJLP6Jhq
         h0EGrNL4xnPaIfg5LlVt2jOy+ymUoET8auoAnS4Z6Sf0JDhxZW/cuJ/gqFw4Gv3uGMuj
         HeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KE04igOM/tFg7wGrex+qvSfHgZMwcZ7hpbE2bEe0+OA=;
        b=KmrazxmJSJtVjfToTd71BE8G/KA8GOXlqSU+RVhLIv1ypN70C7abDaaqI8El0ARfJL
         oT8VcMlsjgTOf8BQ7HCJz7oMTmdPlABaVtDiAgRYSHJveDmOkipFFX1plhCJTr7+XNxh
         wxvQt/dkD9Tmo22Fb7GRnr40HADfG/kH1MF9fRxoLh/GmGpW9Sp29RMyp1sgru3bd+Ni
         rMC4WbzEawOt/ploWv240XDxKUOe8tLVQnL3W9yaK7hVjD4nN4SzOCXxrpRWkki6fywq
         LmB3od3VGcJQ0AAKITBEDBb9Sdu+rZuwhtDd7NuvEu/azDpAvG2GroFM7ZvKjt0nOcw2
         /BxQ==
X-Gm-Message-State: AOAM532StL9RmGVqUNTIdCr3beL/4dFDNR6I+HPqe4r1wRipx+ITEyfC
        kL6IhbKA0ZrxbywNMZ+eNeg+uEE83khqkMVVVaw=
X-Google-Smtp-Source: ABdhPJx3cllAB8qiK4bef0GMMy2M5j0TI2KjGpKOdlar+V/2wtVkmWtjoL/9dzrWLa3A4eN14RD0BJ08+cKH/KugcD8=
X-Received: by 2002:a19:f616:: with SMTP id x22mr11918247lfe.239.1630981472251;
 Mon, 06 Sep 2021 19:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210825184745.2680830-1-fallentree@fb.com> <CAADnVQJz8LUTsm_azd4JE0n5Q4Me0Lze6hmsqNYfAKMeA44_fQ@mail.gmail.com>
 <CAJygYd24KySBLCL2rRofGqdPkQzonxBfihRxLQ=O8Xg=AWAowA@mail.gmail.com>
 <CAJygYd3M1E3N9C02WCmPD6_i9miXaCe=OP-M32QTnOXOajBPZA@mail.gmail.com>
 <CAADnVQJB3GKKr1hMWHNKYhoo8CzrDQ83LEnO8c+ntOBtEkjApA@mail.gmail.com>
 <CAM_iQpVw-5dG8Na9e851bQy2_BcpZQ5QK+r554NZsP0_dbzwNw@mail.gmail.com>
 <CAM_iQpUG30QL03Uh9D_ACy_29TLWG+YfDO9_GvcqzW2f0TbpYw@mail.gmail.com>
 <CAJygYd2f8S5Oq_B8724p-3rQvXaJKMBGgBKLS_0R7fxTew2oeA@mail.gmail.com> <CAM_iQpWt8F18_B5b9cYyT7Ri3sua2T2B5ztEGg2h3v9u2-i+Fg@mail.gmail.com>
In-Reply-To: <CAM_iQpWt8F18_B5b9cYyT7Ri3sua2T2B5ztEGg2h3v9u2-i+Fg@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Mon, 6 Sep 2021 22:24:05 -0400
Message-ID: <CAJygYd2uJNEvX4MWruAZ2a3uJ2HJbnoCmMkuS2fFY59S6x=Sww@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: reduce more flakyness in sockmap_listen
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Cong, sorry for the back and forth. Let me clarify the problem here:

 If you apply following patch on bpf-next, running ./test_progs -t
sockmap_listen and you will observe full timeout on all the select()
calls for these read() , it looks like select() won't work on
redirected socket, which I think is a issue, but would love to hear
what you think.

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 5c5979046523..fe9ba7c51d8f 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1002,15 +1002,9 @@ static void redir_to_connected(int family, int
sotype, int sock_mapfd,
                goto close_peer1;
        if (pass != 1)
                FAIL("%s: want pass count 1, have %d", log_prefix, pass);
-again:
-       n = read(c0, &b, 1);
-       if (n < 0) {
-               if (errno == EAGAIN && retries--) {
-                       usleep(1000);
-                       goto again;
-               }
+       n = recv_timeout(c0, &b, 1, 0, IO_TIMEOUT_SEC);
+       if (n < 0)
                FAIL_ERRNO("%s: read", log_prefix);
-       }
        if (n == 0)
                FAIL("%s: incomplete read", log_prefix);

@@ -1606,15 +1600,9 @@ static void unix_redir_to_connected(int sotype,
int sock_mapfd,
        if (pass != 1)
                FAIL("%s: want pass count 1, have %d", log_prefix, pass);

-again:
-       n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
-       if (n < 0) {
-               if (errno == EAGAIN && retries--) {
-                       usleep(1000);
-                       goto again;
-               }
+       n = recv_timeout(mode == REDIR_INGRESS ? p0 : c0, &b, 1, 0,
IO_TIMEOUT_SEC);
+       if (n < 0)
                FAIL_ERRNO("%s: read", log_prefix);
-       }
        if (n == 0)
                FAIL("%s: incomplete read", log_prefix);

@@ -1781,15 +1769,9 @@ static void udp_redir_to_connected(int family,
int sock_mapfd, int verd
_mapfd,
        if (pass != 1)
                FAIL("%s: want pass count 1, have %d", log_prefix, pass);

-again:
-       n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
-       if (n < 0) {
-               if (errno == EAGAIN && retries--) {
-                       usleep(1000);
-                       goto again;
-               }
+       n = recv_timeout(mode == REDIR_INGRESS ? p0 : c0, &b, 1, 0,
IO_TIMEOUT_SEC);
+       if (n < 0)
                FAIL_ERRNO("%s: read", log_prefix);
-       }
        if (n == 0)
                FAIL("%s: incomplete read", log_prefix);

@@ -1876,15 +1858,9 @@ static void inet_unix_redir_to_connected(int
family, int type, int sock_mapfd,
        if (pass != 1)
                FAIL("%s: want pass count 1, have %d", log_prefix, pass);

-again:
-       n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
-       if (n < 0) {
-               if (errno == EAGAIN && retries--) {
-                       usleep(1000);
-                       goto again;
-               }
+       n = recv_timeout(mode == REDIR_INGRESS ? p0 : c0, &b, 1, 0,
IO_TIMEOUT_SEC);
+       if (n < 0)
                FAIL_ERRNO("%s: read", log_prefix);
-       }
        if (n == 0)
                FAIL("%s: incomplete read", log_prefix);

@@ -1963,15 +1939,9 @@ static void unix_inet_redir_to_connected(int
family, int type, int sock_mapfd,
        if (pass != 1)
                FAIL("%s: want pass count 1, have %d", log_prefix, pass);

-again:
-       n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
-       if (n < 0) {
-               if (errno == EAGAIN && retries--) {
-                       usleep(1000);
-                       goto again;
-               }
+       n = recv_timeout(mode == REDIR_INGRESS ? p0 : c0, &b, 1, 0,
IO_TIMEOUT_SEC);
+       if (n < 0)
                FAIL_ERRNO("%s: read", log_prefix);
-       }
        if (n == 0)
                FAIL("%s: incomplete read", log_prefix);



And the error log is

./test_progs -t sockmap_listen
[    6.568737] bpf_testmod: loading out-of-tree module taints kernel.
#120/1 sockmap_listen/sockmap IPv4 TCP test_insert_invalid:OK
#120/2 sockmap_listen/sockmap IPv4 TCP test_insert_opened:OK
#120/3 sockmap_listen/sockmap IPv4 TCP test_insert_bound:OK
#120/4 sockmap_listen/sockmap IPv4 TCP test_insert:OK
#120/5 sockmap_listen/sockmap IPv4 TCP test_delete_after_insert:OK
#120/6 sockmap_listen/sockmap IPv4 TCP test_delete_after_close:OK
#120/7 sockmap_listen/sockmap IPv4 TCP test_lookup_after_insert:OK
#120/8 sockmap_listen/sockmap IPv4 TCP test_lookup_after_delete:OK
#120/9 sockmap_listen/sockmap IPv4 TCP test_lookup_32_bit_value:OK
#120/10 sockmap_listen/sockmap IPv4 TCP test_update_existing:OK
#120/11 sockmap_listen/sockmap IPv4 TCP test_destroy_orphan_child:OK
#120/12 sockmap_listen/sockmap IPv4 TCP test_syn_recv_insert_delete:OK
#120/13 sockmap_listen/sockmap IPv4 TCP test_race_insert_listen:OK
#120/14 sockmap_listen/sockmap IPv4 TCP test_clone_after_delete:OK
#120/15 sockmap_listen/sockmap IPv4 TCP test_accept_after_delete:OK
#120/16 sockmap_listen/sockmap IPv4 TCP test_accept_before_delete:OK
#120/17 sockmap_listen/sockmap IPv4 UDP test_insert_invalid:OK
#120/18 sockmap_listen/sockmap IPv4 UDP test_insert_opened:OK
#120/19 sockmap_listen/sockmap IPv4 UDP test_insert:OK
#120/20 sockmap_listen/sockmap IPv4 UDP test_delete_after_insert:OK
#120/21 sockmap_listen/sockmap IPv4 UDP test_delete_after_close:OK
#120/22 sockmap_listen/sockmap IPv4 UDP test_lookup_after_insert:OK
#120/23 sockmap_listen/sockmap IPv4 UDP test_lookup_after_delete:OK
#120/24 sockmap_listen/sockmap IPv4 UDP test_lookup_32_bit_value:OK
#120/25 sockmap_listen/sockmap IPv4 UDP test_update_existing:OK
#120/26 sockmap_listen/sockmap IPv4 test_skb_redir_to_connected:OK
#120/27 sockmap_listen/sockmap IPv4 test_skb_redir_to_listening:OK
#120/28 sockmap_listen/sockmap IPv4 test_msg_redir_to_connected:OK
#120/29 sockmap_listen/sockmap IPv4 test_msg_redir_to_listening:OK
#120/30 sockmap_listen/sockmap IPv4 TCP test_reuseport_select_listening:OK
#120/31 sockmap_listen/sockmap IPv4 TCP test_reuseport_select_connected:OK
#120/32 sockmap_listen/sockmap IPv4 TCP test_reuseport_mixed_groups:OK
#120/33 sockmap_listen/sockmap IPv4 UDP test_reuseport_select_listening:OK
#120/34 sockmap_listen/sockmap IPv4 UDP test_reuseport_select_connected:OK
#120/35 sockmap_listen/sockmap IPv4 UDP test_reuseport_mixed_groups:OK
./test_progs:udp_redir_to_connected:1774: ingress: read: Timer expired
udp_redir_to_connected:FAIL:1774
#120/36 sockmap_listen/sockmap IPv4 test_udp_redir:FAIL
./test_progs:inet_unix_redir_to_connected:1863: ingress: read: Timer expired
inet_unix_redir_to_connected:FAIL:1863
./test_progs:inet_unix_redir_to_connected:1863: ingress: read: Timer expired
inet_unix_redir_to_connected:FAIL:1863
./test_progs:unix_inet_redir_to_connected:1944: ingress: read: Timer expired
unix_inet_redir_to_connected:FAIL:1944
./test_progs:unix_inet_redir_to_connected:1944: ingress: read: Timer expired
unix_inet_redir_to_connected:FAIL:1944
#120/37 sockmap_listen/sockmap IPv4 test_udp_unix_redir:FAIL
#120/38 sockmap_listen/sockmap IPv6 TCP test_insert_invalid:OK
#120/39 sockmap_listen/sockmap IPv6 TCP test_insert_opened:OK
#120/40 sockmap_listen/sockmap IPv6 TCP test_insert_bound:OK
#120/41 sockmap_listen/sockmap IPv6 TCP test_insert:OK
#120/42 sockmap_listen/sockmap IPv6 TCP test_delete_after_insert:OK
#120/43 sockmap_listen/sockmap IPv6 TCP test_delete_after_close:OK
#120/44 sockmap_listen/sockmap IPv6 TCP test_lookup_after_insert:OK
#120/45 sockmap_listen/sockmap IPv6 TCP test_lookup_after_delete:OK
#120/46 sockmap_listen/sockmap IPv6 TCP test_lookup_32_bit_value:OK
#120/47 sockmap_listen/sockmap IPv6 TCP test_update_existing:OK
#120/48 sockmap_listen/sockmap IPv6 TCP test_destroy_orphan_child:OK
#120/49 sockmap_listen/sockmap IPv6 TCP test_syn_recv_insert_delete:OK
#120/50 sockmap_listen/sockmap IPv6 TCP test_race_insert_listen:OK
#120/51 sockmap_listen/sockmap IPv6 TCP test_clone_after_delete:OK
#120/52 sockmap_listen/sockmap IPv6 TCP test_accept_after_delete:OK
#120/53 sockmap_listen/sockmap IPv6 TCP test_accept_before_delete:OK
#120/54 sockmap_listen/sockmap IPv6 UDP test_insert_invalid:OK
#120/55 sockmap_listen/sockmap IPv6 UDP test_insert_opened:OK
#120/56 sockmap_listen/sockmap IPv6 UDP test_insert:OK
#120/57 sockmap_listen/sockmap IPv6 UDP test_delete_after_insert:OK
#120/58 sockmap_listen/sockmap IPv6 UDP test_delete_after_close:OK
#120/59 sockmap_listen/sockmap IPv6 UDP test_lookup_after_insert:OK
#120/60 sockmap_listen/sockmap IPv6 UDP test_lookup_after_delete:OK
#120/61 sockmap_listen/sockmap IPv6 UDP test_lookup_32_bit_value:OK
#120/62 sockmap_listen/sockmap IPv6 UDP test_update_existing:OK
#120/63 sockmap_listen/sockmap IPv6 test_skb_redir_to_connected:OK
#120/64 sockmap_listen/sockmap IPv6 test_skb_redir_to_listening:OK
#120/65 sockmap_listen/sockmap IPv6 test_msg_redir_to_connected:OK
#120/66 sockmap_listen/sockmap IPv6 test_msg_redir_to_listening:OK
#120/67 sockmap_listen/sockmap IPv6 TCP test_reuseport_select_listening:OK
#120/68 sockmap_listen/sockmap IPv6 TCP test_reuseport_select_connected:OK
#120/69 sockmap_listen/sockmap IPv6 TCP test_reuseport_mixed_groups:OK
#120/70 sockmap_listen/sockmap IPv6 UDP test_reuseport_select_listening:OK
#120/71 sockmap_listen/sockmap IPv6 UDP test_reuseport_select_connected:OK
#120/72 sockmap_listen/sockmap IPv6 UDP test_reuseport_mixed_groups:OK
./test_progs:udp_redir_to_connected:1774: ingress: read: Timer expired
udp_redir_to_connected:FAIL:1774
#120/73 sockmap_listen/sockmap IPv6 test_udp_redir:FAIL
./test_progs:inet_unix_redir_to_connected:1863: ingress: read: Timer expired
inet_unix_redir_to_connected:FAIL:1863
./test_progs:inet_unix_redir_to_connected:1863: ingress: read: Timer expired
inet_unix_redir_to_connected:FAIL:1863
./test_progs:unix_inet_redir_to_connected:1944: ingress: read: Timer expired
unix_inet_redir_to_connected:FAIL:1944
./test_progs:unix_inet_redir_to_connected:1944: ingress: read: Timer expired
unix_inet_redir_to_connected:FAIL:1944
#120/74 sockmap_listen/sockmap IPv6 test_udp_unix_redir:FAIL
./test_progs:unix_redir_to_connected:1605: ingress: read: Timer expired
unix_redir_to_connected:FAIL:1605
#120/75 sockmap_listen/sockmap Unix test_unix_redir:FAIL
./test_progs:unix_redir_to_connected:1605: ingress: read: Timer expired
unix_redir_to_connected:FAIL:1605
#120/76 sockmap_listen/sockmap Unix test_unix_redir:FAIL
#120/77 sockmap_listen/sockhash IPv4 TCP test_insert_invalid:OK
#120/78 sockmap_listen/sockhash IPv4 TCP test_insert_opened:OK
#120/79 sockmap_listen/sockhash IPv4 TCP test_insert_bound:OK
#120/80 sockmap_listen/sockhash IPv4 TCP test_insert:OK
#120/81 sockmap_listen/sockhash IPv4 TCP test_delete_after_insert:OK
#120/82 sockmap_listen/sockhash IPv4 TCP test_delete_after_close:OK
#120/83 sockmap_listen/sockhash IPv4 TCP test_lookup_after_insert:OK
#120/84 sockmap_listen/sockhash IPv4 TCP test_lookup_after_delete:OK
#120/85 sockmap_listen/sockhash IPv4 TCP test_lookup_32_bit_value:OK
#120/86 sockmap_listen/sockhash IPv4 TCP test_update_existing:OK
#120/87 sockmap_listen/sockhash IPv4 TCP test_destroy_orphan_child:OK
#120/88 sockmap_listen/sockhash IPv4 TCP test_syn_recv_insert_delete:OK
#120/89 sockmap_listen/sockhash IPv4 TCP test_race_insert_listen:OK
#120/90 sockmap_listen/sockhash IPv4 TCP test_clone_after_delete:OK
#120/91 sockmap_listen/sockhash IPv4 TCP test_accept_after_delete:OK
#120/92 sockmap_listen/sockhash IPv4 TCP test_accept_before_delete:OK
#120/93 sockmap_listen/sockhash IPv4 UDP test_insert_invalid:OK
#120/94 sockmap_listen/sockhash IPv4 UDP test_insert_opened:OK
#120/95 sockmap_listen/sockhash IPv4 UDP test_insert:OK
#120/96 sockmap_listen/sockhash IPv4 UDP test_delete_after_insert:OK
#120/97 sockmap_listen/sockhash IPv4 UDP test_delete_after_close:OK
#120/98 sockmap_listen/sockhash IPv4 UDP test_lookup_after_insert:OK
#120/99 sockmap_listen/sockhash IPv4 UDP test_lookup_after_delete:OK
#120/100 sockmap_listen/sockhash IPv4 UDP test_lookup_32_bit_value:OK
#120/101 sockmap_listen/sockhash IPv4 UDP test_update_existing:OK
#120/102 sockmap_listen/sockhash IPv4 test_skb_redir_to_connected:OK
#120/103 sockmap_listen/sockhash IPv4 test_skb_redir_to_listening:OK
#120/104 sockmap_listen/sockhash IPv4 test_msg_redir_to_connected:OK
#120/105 sockmap_listen/sockhash IPv4 test_msg_redir_to_listening:OK
#120/106 sockmap_listen/sockhash IPv4 TCP test_reuseport_select_listening:OK
#120/107 sockmap_listen/sockhash IPv4 TCP test_reuseport_select_connected:OK
#120/108 sockmap_listen/sockhash IPv4 TCP test_reuseport_mixed_groups:OK
#120/109 sockmap_listen/sockhash IPv4 UDP test_reuseport_select_listening:OK
#120/110 sockmap_listen/sockhash IPv4 UDP test_reuseport_select_connected:OK
#120/111 sockmap_listen/sockhash IPv4 UDP test_reuseport_mixed_groups:OK
./test_progs:udp_redir_to_connected:1774: ingress: read: Timer expired
udp_redir_to_connected:FAIL:1774
#120/112 sockmap_listen/sockhash IPv4 test_udp_redir:FAIL
./test_progs:inet_unix_redir_to_connected:1863: ingress: read: Timer expired
inet_unix_redir_to_connected:FAIL:1863
./test_progs:inet_unix_redir_to_connected:1863: ingress: read: Timer expired
inet_unix_redir_to_connected:FAIL:1863
./test_progs:unix_inet_redir_to_connected:1944: ingress: read: Timer expired
unix_inet_redir_to_connected:FAIL:1944
./test_progs:unix_inet_redir_to_connected:1944: ingress: read: Timer expired
unix_inet_redir_to_connected:FAIL:1944
#120/113 sockmap_listen/sockhash IPv4 test_udp_unix_redir:FAIL
#120/114 sockmap_listen/sockhash IPv6 TCP test_insert_invalid:OK
#120/115 sockmap_listen/sockhash IPv6 TCP test_insert_opened:OK
#120/116 sockmap_listen/sockhash IPv6 TCP test_insert_bound:OK
#120/117 sockmap_listen/sockhash IPv6 TCP test_insert:OK
#120/118 sockmap_listen/sockhash IPv6 TCP test_delete_after_insert:OK
#120/119 sockmap_listen/sockhash IPv6 TCP test_delete_after_close:OK
#120/120 sockmap_listen/sockhash IPv6 TCP test_lookup_after_insert:OK
#120/121 sockmap_listen/sockhash IPv6 TCP test_lookup_after_delete:OK
#120/122 sockmap_listen/sockhash IPv6 TCP test_lookup_32_bit_value:OK
#120/123 sockmap_listen/sockhash IPv6 TCP test_update_existing:OK
#120/124 sockmap_listen/sockhash IPv6 TCP test_destroy_orphan_child:OK
#120/125 sockmap_listen/sockhash IPv6 TCP test_syn_recv_insert_delete:OK
#120/126 sockmap_listen/sockhash IPv6 TCP test_race_insert_listen:OK
#120/127 sockmap_listen/sockhash IPv6 TCP test_clone_after_delete:OK
#120/128 sockmap_listen/sockhash IPv6 TCP test_accept_after_delete:OK
#120/129 sockmap_listen/sockhash IPv6 TCP test_accept_before_delete:OK
#120/130 sockmap_listen/sockhash IPv6 UDP test_insert_invalid:OK
#120/131 sockmap_listen/sockhash IPv6 UDP test_insert_opened:OK
#120/132 sockmap_listen/sockhash IPv6 UDP test_insert:OK
#120/133 sockmap_listen/sockhash IPv6 UDP test_delete_after_insert:OK
#120/134 sockmap_listen/sockhash IPv6 UDP test_delete_after_close:OK
#120/135 sockmap_listen/sockhash IPv6 UDP test_lookup_after_insert:OK
#120/136 sockmap_listen/sockhash IPv6 UDP test_lookup_after_delete:OK
#120/137 sockmap_listen/sockhash IPv6 UDP test_lookup_32_bit_value:OK
#120/138 sockmap_listen/sockhash IPv6 UDP test_update_existing:OK
#120/139 sockmap_listen/sockhash IPv6 test_skb_redir_to_connected:OK
#120/140 sockmap_listen/sockhash IPv6 test_skb_redir_to_listening:OK
#120/141 sockmap_listen/sockhash IPv6 test_msg_redir_to_connected:OK
#120/142 sockmap_listen/sockhash IPv6 test_msg_redir_to_listening:OK
#120/143 sockmap_listen/sockhash IPv6 TCP test_reuseport_select_listening:OK
#120/144 sockmap_listen/sockhash IPv6 TCP test_reuseport_select_connected:OK
#120/145 sockmap_listen/sockhash IPv6 TCP test_reuseport_mixed_groups:OK
#120/146 sockmap_listen/sockhash IPv6 UDP test_reuseport_select_listening:OK
#120/147 sockmap_listen/sockhash IPv6 UDP test_reuseport_select_connected:OK
#120/148 sockmap_listen/sockhash IPv6 UDP test_reuseport_mixed_groups:OK
./test_progs:udp_redir_to_connected:1774: ingress: read: Timer expired
udp_redir_to_connected:FAIL:1774
#120/149 sockmap_listen/sockhash IPv6 test_udp_redir:FAIL
./test_progs:inet_unix_redir_to_connected:1863: ingress: read: Timer expired
inet_unix_redir_to_connected:FAIL:1863
./test_progs:inet_unix_redir_to_connected:1863: ingress: read: Timer expired
inet_unix_redir_to_connected:FAIL:1863
./test_progs:unix_inet_redir_to_connected:1944: ingress: read: Timer expired
unix_inet_redir_to_connected:FAIL:1944
./test_progs:unix_inet_redir_to_connected:1944: ingress: read: Timer expired
unix_inet_redir_to_connected:FAIL:1944
#120/150 sockmap_listen/sockhash IPv6 test_udp_unix_redir:FAIL
./test_progs:unix_redir_to_connected:1605: ingress: read: Timer expired
unix_redir_to_connected:FAIL:1605
#120/151 sockmap_listen/sockhash Unix test_unix_redir:FAIL
./test_progs:unix_redir_to_connected:1605: ingress: read: Timer expired
unix_redir_to_connected:FAIL:1605
#120/152 sockmap_listen/sockhash Unix test_unix_redir:FAIL
#120 sockmap_listen:FAIL
Summary: 0/140 PASSED, 0 SKIPPED, 13 FAILED

On Fri, Sep 3, 2021 at 7:44 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> On Wed, Sep 1, 2021 at 8:35 PM sunyucong@gmail.com <sunyucong@gmail.com> wrote:
> >
> > On Wed, Sep 1, 2021 at 9:33 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > >
> > > On Tue, Aug 31, 2021 at 12:33 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > > > Like I mentioned before, I suspect there is some delay in one of
> > > > the queues on the way or there is a worker wakeup latency.
> > > > I will try adding some tracepoints to see if I can capture it.
> > > >
> > >
> > > I tried to revert this patch locally to reproduce the EAGAIN
> > > failure, but even after repeating the sockmap_listen test hundreds
> > > of times, I didn't see any failure here.
> > >
> > > If you are still interested in this issue, I'd suggest you adding some
> > > tracepoints to see what happens to kworker or the packet queues.
> > >
> > > It does not look like a sockmap bug, otherwise I would be able to
> > > reproduce it here.
> > >
> >
> > Cong, the issue is not that read() sometimes returns EAGAIN.
> >
> > It is that when using select on the redirected socket,  it will hang forever.
>
> Hmm? We don't use any select(), do we? Before your patch, I used
> a for loop. With your patch, it is a loop with usleep().
>
> Actually I just reproduced this EAGAIN issue here. I ran `git revert`
> but it didn't actually revert your patch for some reason, so I had to
> manually remove those usleep() and finally reproduced it.
>
> I used strace -ttt to get the time spent on 100 times of read(), it is
> about 0.2ms in total. However, runqslower shows the kworker wakeup
> latency can be 10+ms:
>
> 19:29:16 kworker/2:0      19836           14071
> 19:29:18 kworker/1:0      19836           14369
> 19:29:20 ksoftirqd/2      19794           12731
> 19:29:20 kworker/2:0      23              11059
> 19:29:21 kworker/1:0      19836           11020
>
> So clearly repeating read() for 100 times is too far away from the worst
> delay. And the wakeup latency is only part of the packet latency, so in
> other words, in the worst scenario a packet can be delayed for more
> than 10ms, which is roughly 5000 times of read().
>
> Anyway, this is a not a bug in sockmap, it is a problem of not using
> blocking mode in sockmap_listen tests.
>
> Thanks.
