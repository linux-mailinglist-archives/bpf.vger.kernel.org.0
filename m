Return-Path: <bpf+bounces-13675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23E67DC5D9
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5BF1C20B8C
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 05:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B2DD275;
	Tue, 31 Oct 2023 05:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifqDVqwA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381F7CA7C
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 05:23:11 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F426D8
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:23:08 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9c2a0725825so836044866b.2
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698729780; x=1699334580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuDalRrCyGqUlwCGtXb0yZFwrGGsAp6YOW1GGO+W2mM=;
        b=ifqDVqwAo04F37eaQUmIFhWDJ0qUsJpYY10fI+0AGwfdhH0J4NO3wswDnYCvbM0/ko
         mI4gfRR5w+getgWf4E3dG0wl04DL9jbuFneHtqK4dVhXgtCuu1vm/DgHiuAU3Q35r9lY
         idY1qPDB146pM94jvozg6TPs/pmQssIsgbZB5OXT8cQ/acACxQ6rhOcGGCxU3jhQ2Ilb
         vhcfGbK1zmqznvZtKv40LYVpdT7gVXiVusUzW8sFcbvbrHdIr7FxGbNjK3bBvY0ZrJ3N
         /ECVDZxYoQlaOqmxjkRWwk48QhTsbeUKhFKcBmK3L+HE2HyYmipTCOYzU8F+XCkd2GLA
         xUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698729780; x=1699334580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuDalRrCyGqUlwCGtXb0yZFwrGGsAp6YOW1GGO+W2mM=;
        b=JcYNIRyxo72vKAkOeH2GWfDfz2zT1pRqaDuhfHs3kOvVcQRNHK2U7bnD+SDXkIRsC+
         vKTUTf19hPiI+OnzBx4NI50HZcxp8cfrV1CC+DlVKoAFJ2b09EUKRtATNR6317Fka/1C
         cwTXbZviJBlbHpFgWRZaFUIM5MKcCALPHVDnjZZS0Db/j68EW/5VJd9ejrkS4IaNc3tm
         4Vr+v0+we/vGrVAdexY28FBeyzdQZfliZj4WqSMx+C/unHgeXmek/7wDmnaT6i92DXOT
         x0c1rA69TRPt+i0I75VvqkUZf/leas2PPf1Hmlc6kkAdEZVl8dQ1qnqcxnCxJJWwtr0g
         FbWw==
X-Gm-Message-State: AOJu0YzPRBuxbkbjXL0CRinFDLkBL1ntpeZ1u4Uh64xDweqDMfMeB/oX
	UxgZmlDm+V4za9+opUXrEDkEB6LJvUHBlkElIwrf3U8W
X-Google-Smtp-Source: AGHT+IGgpr7uxRK9sHPoTOBdqpkL2ksHsua6XiTeDynLan/fZEG26g20KT/8wCihmqBQ0sMpOhnjJSECtajv6jWvFKw=
X-Received: by 2002:a17:907:3da9:b0:9ae:5be8:ff90 with SMTP id
 he41-20020a1709073da900b009ae5be8ff90mr10749921ejc.68.1698729779524; Mon, 30
 Oct 2023 22:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031050324.1107444-1-andrii@kernel.org> <20231031050324.1107444-8-andrii@kernel.org>
In-Reply-To: <20231031050324.1107444-8-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Oct 2023 22:22:48 -0700
Message-ID: <CAEf4Bzbnpf-Kf+71TtwrBL2d9yyuBS3289KqtVA6cEtOQiwQjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/7] bpf: track aligned STACK_ZERO cases as
 imprecise spilled registers
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 10:03=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> Now that precision backtracing is supporting register spill/fill to/from
> stack, there is another oportunity to be exploited here: minimizing
> precise STACK_ZERO cases. With a simple code change we can rely on
> initially imprecise register spill tracking for cases when register
> spilled to stack was a known zero.
>
> This is a very common case for initializing on the stack variables,
> including rather large structures. Often times zero has no special
> meaning for the subsequent BPF program logic and is often overwritten
> with non-zero values soon afterwards. But due to STACK_ZERO vs
> STACK_MISC tracking, such initial zero initialization actually causes
> duplication of verifier states as STACK_ZERO is clearly different than
> STACK_MISC or spilled SCALAR_VALUE register.
>
> The effect of this (now) trivial change is huge, as can be seen below.
> These are differences between BPF selftests, Cilium, and Meta-internal
> BPF object files relative to previous patch in this series. You can see
> improvements ranging from single-digit percentage improvement for
> instructions and states, all the way to 50-60% reduction for some of
> Meta-internal host agent programs, and even some Cilium programs.
>
> For Meta-internal ones I left only the differences for largest BPF
> object files by states/instructions, as there were too many differences
> in the overall output. All the differences were improvements, reducting
> number of states and thus instructions validated.
>
> Note, Meta-internal BPF object file names are not printed below.
> Many copies of balancer_ingress are actually many different
> configurations of Katran, so they are different BPF programs, which
> explains state reduction going from -16% all the way to 31%, depending
> on BPF program logic complexity.
>
> SELFTESTS
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> File                                     Program                  Insns (=
A)  Insns (B)  Insns    (DIFF)  States (A)  States (B)  States (DIFF)
> ---------------------------------------  -----------------------  -------=
--  ---------  ---------------  ----------  ----------  -------------
> bpf_iter_netlink.bpf.linked3.o           dump_netlink                   1=
48        104    -44 (-29.73%)           8           5   -3 (-37.50%)
> bpf_iter_unix.bpf.linked3.o              dump_unix                     84=
74       8404     -70 (-0.83%)         151         147    -4 (-2.65%)
> bpf_loop.bpf.linked3.o                   stack_check                    5=
60        324   -236 (-42.14%)          42          24  -18 (-42.86%)
> local_storage_bench.bpf.linked3.o        get_local                      1=
20         77    -43 (-35.83%)           9           6   -3 (-33.33%)
> loop6.bpf.linked3.o                      trace_virtqueue_add_sgs      101=
67       9868    -299 (-2.94%)         226         206   -20 (-8.85%)
> pyperf600_bpf_loop.bpf.linked3.o         on_event                      48=
72       3423  -1449 (-29.74%)         322         229  -93 (-28.88%)
> strobemeta.bpf.linked3.o                 on_event                    1806=
97     176036   -4661 (-2.58%)        4780        4734   -46 (-0.96%)
> test_cls_redirect.bpf.linked3.o          cls_redirect                 655=
94      65401    -193 (-0.29%)        4230        4212   -18 (-0.43%)
> test_global_func_args.bpf.linked3.o      test_cls                       1=
45        136      -9 (-6.21%)          10           9   -1 (-10.00%)
> test_l4lb.bpf.linked3.o                  balancer_ingress              47=
60       2612  -2148 (-45.13%)         113         102   -11 (-9.73%)
> test_l4lb_noinline.bpf.linked3.o         balancer_ingress              48=
45       4877     +32 (+0.66%)         219         221    +2 (+0.91%)
> test_l4lb_noinline_dynptr.bpf.linked3.o  balancer_ingress              20=
72       2087     +15 (+0.72%)          97          98    +1 (+1.03%)
> test_seg6_loop.bpf.linked3.o             __add_egr_x                  124=
40       9975  -2465 (-19.82%)         364         353   -11 (-3.02%)
> test_tcp_hdr_options.bpf.linked3.o       estab                         25=
58       2572     +14 (+0.55%)         179         180    +1 (+0.56%)
> test_xdp_dynptr.bpf.linked3.o            _xdp_tx_iptunnel               6=
45        596     -49 (-7.60%)          26          24    -2 (-7.69%)
> test_xdp_noinline.bpf.linked3.o          balancer_ingress_v6           35=
20       3516      -4 (-0.11%)         216         216    +0 (+0.00%)
> xdp_synproxy_kern.bpf.linked3.o          syncookie_tc                 826=
61      81241   -1420 (-1.72%)        5073        5155   +82 (+1.62%)
> xdp_synproxy_kern.bpf.linked3.o          syncookie_xdp                849=
64      82297   -2667 (-3.14%)        5130        5157   +27 (+0.53%)
>
> META-INTERNAL
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Program                                 Insns (A)  Insns (B)  Insns      =
(DIFF)  States (A)  States (B)  States   (DIFF)
> --------------------------------------  ---------  ---------  -----------=
------  ----------  ----------  ---------------
> balancer_ingress                            27925      23608    -4317 (-1=
5.46%)        1488        1482      -6 (-0.40%)
> balancer_ingress                            31824      27546    -4278 (-1=
3.44%)        1658        1652      -6 (-0.36%)
> balancer_ingress                            32213      27935    -4278 (-1=
3.28%)        1689        1683      -6 (-0.36%)
> balancer_ingress                            32213      27935    -4278 (-1=
3.28%)        1689        1683      -6 (-0.36%)
> balancer_ingress                            31824      27546    -4278 (-1=
3.44%)        1658        1652      -6 (-0.36%)
> balancer_ingress                            38647      29562    -9085 (-2=
3.51%)        2069        1835   -234 (-11.31%)
> balancer_ingress                            38647      29562    -9085 (-2=
3.51%)        2069        1835   -234 (-11.31%)
> balancer_ingress                            40339      30792    -9547 (-2=
3.67%)        2193        1934   -259 (-11.81%)
> balancer_ingress                            37321      29055    -8266 (-2=
2.15%)        1972        1795    -177 (-8.98%)
> balancer_ingress                            38176      29753    -8423 (-2=
2.06%)        2008        1831    -177 (-8.81%)
> balancer_ingress                            29193      20910    -8283 (-2=
8.37%)        1599        1422   -177 (-11.07%)
> balancer_ingress                            30013      21452    -8561 (-2=
8.52%)        1645        1447   -198 (-12.04%)
> balancer_ingress                            28691      24290    -4401 (-1=
5.34%)        1545        1531     -14 (-0.91%)
> balancer_ingress                            34223      28965    -5258 (-1=
5.36%)        1984        1875    -109 (-5.49%)
> balancer_ingress                            35481      26158    -9323 (-2=
6.28%)        2095        1806   -289 (-13.79%)
> balancer_ingress                            35481      26158    -9323 (-2=
6.28%)        2095        1806   -289 (-13.79%)
> balancer_ingress                            35868      26455    -9413 (-2=
6.24%)        2140        1827   -313 (-14.63%)
> balancer_ingress                            35868      26455    -9413 (-2=
6.24%)        2140        1827   -313 (-14.63%)
> balancer_ingress                            35481      26158    -9323 (-2=
6.28%)        2095        1806   -289 (-13.79%)
> balancer_ingress                            35481      26158    -9323 (-2=
6.28%)        2095        1806   -289 (-13.79%)
> balancer_ingress                            34844      29485    -5359 (-1=
5.38%)        2036        1918    -118 (-5.80%)
> fbflow_egress                                3256       2652     -604 (-1=
8.55%)         218         192    -26 (-11.93%)
> fbflow_ingress                               1026        944       -82 (-=
7.99%)          70          63     -7 (-10.00%)
> sslwall_tc_egress                            8424       7360    -1064 (-1=
2.63%)         498         458     -40 (-8.03%)
> syar_accept_protect                         15040       9539    -5501 (-3=
6.58%)         364         220   -144 (-39.56%)
> syar_connect_tcp_v6                         15036       9535    -5501 (-3=
6.59%)         360         216   -144 (-40.00%)
> syar_connect_udp_v4                         15039       9538    -5501 (-3=
6.58%)         361         217   -144 (-39.89%)
> syar_connect_connect4_protect4              24805      15833    -8972 (-3=
6.17%)         756         480   -276 (-36.51%)
> syar_lsm_file_open                         167772     151813    -15959 (-=
9.51%)        1836        1667    -169 (-9.20%)
> syar_namespace_create_new                   14805       9304    -5501 (-3=
7.16%)         353         209   -144 (-40.79%)
> syar_python3_detect                         17531      12030    -5501 (-3=
1.38%)         391         247   -144 (-36.83%)
> syar_ssh_post_fork                          16412      10911    -5501 (-3=
3.52%)         405         261   -144 (-35.56%)
> syar_enter_execve                           14728       9227    -5501 (-3=
7.35%)         345         201   -144 (-41.74%)
> syar_enter_execveat                         14728       9227    -5501 (-3=
7.35%)         345         201   -144 (-41.74%)
> syar_exit_execve                            16622      11121    -5501 (-3=
3.09%)         376         232   -144 (-38.30%)
> syar_exit_execveat                          16622      11121    -5501 (-3=
3.09%)         376         232   -144 (-38.30%)
> syar_syscalls_kill                          15288       9787    -5501 (-3=
5.98%)         398         254   -144 (-36.18%)
> syar_task_enter_pivot_root                  14898       9397    -5501 (-3=
6.92%)         357         213   -144 (-40.34%)
> syar_syscalls_setreuid                      16678      11177    -5501 (-3=
2.98%)         429         285   -144 (-33.57%)
> syar_syscalls_setuid                        16678      11177    -5501 (-3=
2.98%)         429         285   -144 (-33.57%)
> syar_syscalls_process_vm_readv              14959       9458    -5501 (-3=
6.77%)         364         220   -144 (-39.56%)
> syar_syscalls_process_vm_writev             15757      10256    -5501 (-3=
4.91%)         390         246   -144 (-36.92%)
> do_uprobe                                   15519      10018    -5501 (-3=
5.45%)         373         229   -144 (-38.61%)
> edgewall                                   179715      55783  -123932 (-6=
8.96%)       12607        3999  -8608 (-68.28%)
> bictcp_state                                 7570       4131    -3439 (-4=
5.43%)         496         269   -227 (-45.77%)
> cubictcp_state                               7570       4131    -3439 (-4=
5.43%)         496         269   -227 (-45.77%)
> tcp_rate_skb_delivered                        447        272     -175 (-3=
9.15%)          29          18    -11 (-37.93%)
> kprobe__bbr_set_state                        4566       2615    -1951 (-4=
2.73%)         209         124    -85 (-40.67%)
> kprobe__bictcp_state                         4566       2615    -1951 (-4=
2.73%)         209         124    -85 (-40.67%)
> inet_sock_set_state                          1501       1337     -164 (-1=
0.93%)          93          85      -8 (-8.60%)
> tcp_retransmit_skb                           1145        981     -164 (-1=
4.32%)          67          59     -8 (-11.94%)
> tcp_retransmit_synack                        1183        951     -232 (-1=
9.61%)          67          55    -12 (-17.91%)
> bpf_tcptuner                                 1459       1187     -272 (-1=
8.64%)          99          80    -19 (-19.19%)
> tw_egress                                     801        776       -25 (-=
3.12%)          69          66      -3 (-4.35%)
> tw_ingress                                    795        770       -25 (-=
3.14%)          69          66      -3 (-4.35%)
> ttls_tc_ingress                             19025      19383      +358 (+=
1.88%)         470         465      -5 (-1.06%)
> ttls_nat_egress                               490        299     -191 (-3=
8.98%)          33          20    -13 (-39.39%)
> ttls_nat_ingress                              448        285     -163 (-3=
6.38%)          32          21    -11 (-34.38%)
> tw_twfw_egress                             511127     212071  -299056 (-5=
8.51%)       16733        8504  -8229 (-49.18%)
> tw_twfw_ingress                            500095     212069  -288026 (-5=
7.59%)       16223        8504  -7719 (-47.58%)
> tw_twfw_tc_eg                              511113     212064  -299049 (-5=
8.51%)       16732        8504  -8228 (-49.18%)
> tw_twfw_tc_in                              500095     212069  -288026 (-5=
7.59%)       16223        8504  -7719 (-47.58%)
> tw_twfw_egress                              12632      12435      -197 (-=
1.56%)         276         260     -16 (-5.80%)
> tw_twfw_ingress                             12631      12454      -177 (-=
1.40%)         278         261     -17 (-6.12%)
> tw_twfw_tc_eg                               12595      12435      -160 (-=
1.27%)         274         259     -15 (-5.47%)
> tw_twfw_tc_in                               12631      12454      -177 (-=
1.40%)         278         261     -17 (-6.12%)
> tw_xdp_dump                                   266        209      -57 (-2=
1.43%)           9           8     -1 (-11.11%)
>
> CILIUM
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> File           Program                           Insns (A)  Insns (B)  In=
sns     (DIFF)  States (A)  States (B)  States  (DIFF)
> -------------  --------------------------------  ---------  ---------  --=
--------------  ----------  ----------  --------------
> bpf_host.o     cil_to_netdev                          6047       4578   -=
1469 (-24.29%)         362         249  -113 (-31.22%)
> bpf_host.o     handle_lxc_traffic                     2227       1585    =
-642 (-28.83%)         156         103   -53 (-33.97%)
> bpf_host.o     tail_handle_ipv4_from_netdev           2244       1458    =
-786 (-35.03%)         163         106   -57 (-34.97%)
> bpf_host.o     tail_handle_nat_fwd_ipv4              21022      10479  -1=
0543 (-50.15%)        1289         670  -619 (-48.02%)
> bpf_host.o     tail_handle_nat_fwd_ipv6              15433      11375   -=
4058 (-26.29%)         905         643  -262 (-28.95%)
> bpf_host.o     tail_ipv4_host_policy_ingress          2219       1367    =
-852 (-38.40%)         161          96   -65 (-40.37%)
> bpf_host.o     tail_nodeport_nat_egress_ipv4         22460      19862   -=
2598 (-11.57%)        1469        1293  -176 (-11.98%)
> bpf_host.o     tail_nodeport_nat_ingress_ipv4         5526       3534   -=
1992 (-36.05%)         366         243  -123 (-33.61%)
> bpf_host.o     tail_nodeport_nat_ingress_ipv6         5132       4256    =
-876 (-17.07%)         241         219    -22 (-9.13%)
> bpf_host.o     tail_nodeport_nat_ipv6_egress          3702       3542    =
 -160 (-4.32%)         215         205    -10 (-4.65%)
> bpf_lxc.o      tail_handle_nat_fwd_ipv4              21022      10479  -1=
0543 (-50.15%)        1289         670  -619 (-48.02%)
> bpf_lxc.o      tail_handle_nat_fwd_ipv6              15433      11375   -=
4058 (-26.29%)         905         643  -262 (-28.95%)
> bpf_lxc.o      tail_ipv4_ct_egress                    5073       3374   -=
1699 (-33.49%)         262         172   -90 (-34.35%)
> bpf_lxc.o      tail_ipv4_ct_ingress                   5093       3385   -=
1708 (-33.54%)         262         172   -90 (-34.35%)
> bpf_lxc.o      tail_ipv4_ct_ingress_policy_only       5093       3385   -=
1708 (-33.54%)         262         172   -90 (-34.35%)
> bpf_lxc.o      tail_ipv6_ct_egress                    4593       3878    =
-715 (-15.57%)         194         151   -43 (-22.16%)
> bpf_lxc.o      tail_ipv6_ct_ingress                   4606       3891    =
-715 (-15.52%)         194         151   -43 (-22.16%)
> bpf_lxc.o      tail_ipv6_ct_ingress_policy_only       4606       3891    =
-715 (-15.52%)         194         151   -43 (-22.16%)
> bpf_lxc.o      tail_nodeport_nat_ingress_ipv4         5526       3534   -=
1992 (-36.05%)         366         243  -123 (-33.61%)
> bpf_lxc.o      tail_nodeport_nat_ingress_ipv6         5132       4256    =
-876 (-17.07%)         241         219    -22 (-9.13%)
> bpf_overlay.o  tail_handle_nat_fwd_ipv4              20524      10114  -1=
0410 (-50.72%)        1271         638  -633 (-49.80%)
> bpf_overlay.o  tail_nodeport_nat_egress_ipv4         22718      19490   -=
3228 (-14.21%)        1475        1275  -200 (-13.56%)
> bpf_overlay.o  tail_nodeport_nat_ingress_ipv4         5526       3534   -=
1992 (-36.05%)         366         243  -123 (-33.61%)
> bpf_overlay.o  tail_nodeport_nat_ingress_ipv6         5132       4256    =
-876 (-17.07%)         241         219    -22 (-9.13%)
> bpf_overlay.o  tail_nodeport_nat_ipv6_egress          3638       3548    =
  -90 (-2.47%)         209         203     -6 (-2.87%)
> bpf_overlay.o  tail_rev_nodeport_lb4                  4368       3820    =
-548 (-12.55%)         248         215   -33 (-13.31%)
> bpf_overlay.o  tail_rev_nodeport_lb6                  2867       2428    =
-439 (-15.31%)         167         140   -27 (-16.17%)
> bpf_sock.o     cil_sock6_connect                      1718       1703    =
  -15 (-0.87%)         100          99     -1 (-1.00%)
> bpf_xdp.o      tail_handle_nat_fwd_ipv4              12917      12443    =
 -474 (-3.67%)         875         849    -26 (-2.97%)
> bpf_xdp.o      tail_handle_nat_fwd_ipv6              13515      13264    =
 -251 (-1.86%)         715         702    -13 (-1.82%)
> bpf_xdp.o      tail_lb_ipv4                          39492      36367    =
-3125 (-7.91%)        2430        2251   -179 (-7.37%)
> bpf_xdp.o      tail_lb_ipv6                          80441      78058    =
-2383 (-2.96%)        3647        3523   -124 (-3.40%)
> bpf_xdp.o      tail_nodeport_ipv6_dsr                 1038        901    =
-137 (-13.20%)          61          55     -6 (-9.84%)
> bpf_xdp.o      tail_nodeport_nat_egress_ipv4         13027      12096    =
 -931 (-7.15%)         868         809    -59 (-6.80%)
> bpf_xdp.o      tail_nodeport_nat_ingress_ipv4         7617       5900   -=
1717 (-22.54%)         522         413  -109 (-20.88%)
> bpf_xdp.o      tail_nodeport_nat_ingress_ipv6         7575       7395    =
 -180 (-2.38%)         383         374     -9 (-2.35%)
> bpf_xdp.o      tail_rev_nodeport_lb4                  6808       6739    =
  -69 (-1.01%)         403         396     -7 (-1.74%)
> bpf_xdp.o      tail_rev_nodeport_lb6                 16173      15847    =
 -326 (-2.02%)        1010         990    -20 (-1.98%)
>

So I also want to mention that while I did spot check a few programs
(not the biggest ones) and they did seem to have correct verification
flow, I obviously can't easily validate verifier log_level=3D2 logs for
all of the changes above, especially those multi-thousand state
programs. I'd really appreciate someone from Isovalent/Cilium to do
some checking of the Cilium program or two for sanity, just in case.
Thanks!

> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8cfe060e4938..e42ce974b106 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4668,8 +4668,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
>                 return err;
>
>         mark_stack_slot_scratched(env, spi);
> -       if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
> -           !register_is_null(reg) && env->bpf_capable) {
> +       if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) && e=
nv->bpf_capable) {
>                 save_register_state(env, state, spi, reg, size);
>                 /* Break the relation on a narrowing spill. */
>                 if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
> @@ -4718,7 +4717,12 @@ static int check_stack_write_fixed_off(struct bpf_=
verifier_env *env,
>                 /* when we zero initialize stack slots mark them as such =
*/
>                 if ((reg && register_is_null(reg)) ||
>                     (!reg && is_bpf_st_mem(insn) && insn->imm =3D=3D 0)) =
{
> -                       /* backtracking doesn't work for STACK_ZERO yet. =
*/
> +                       /* STACK_ZERO case happened because register spil=
l
> +                        * wasn't properly aligned at the stack slot boun=
dary,
> +                        * so it's not a register spill anymore; force
> +                        * originating register to be precise to make
> +                        * STACK_ZERO correct for subsequent states
> +                        */
>                         err =3D mark_chain_precision(env, value_regno);
>                         if (err)
>                                 return err;
> --
> 2.34.1
>

