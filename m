Return-Path: <bpf+bounces-13933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD64E7DEF42
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 10:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8969F281B02
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 09:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895E5125BD;
	Thu,  2 Nov 2023 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoF3YGRx"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6458D6FA5
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 09:54:30 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CACDF7
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 02:54:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32fb1c35fe0so7703f8f.1
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698918863; x=1699523663; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DAzUNXtHOjlwJshj2Ydw2hInR5ITIItZb/QptLN8SqQ=;
        b=KoF3YGRxe/CNDy8MY7PQ82ooQ4HqLNpxFQ8b92ye1c/nJAz6wA82SqCLjNRekVDgpz
         l1Z2xJc3bXlbVCawJABXhojVWKGompYGQ33fvMu6dW6ITN2n+lVsK+DAphNlSYfYO60R
         aacQSe3pN5tOlMpR8uwsUa8ese2vcKzFy3Qo/ICOYS0U/RakXSbq1ybXyX3VinX00HR0
         Wbr8Wye6noWxgEJKxTjBf3ik3mjgNHLm1PyfIUK1AGNV0BWNonRkV9ALqcJRlmn11oA4
         f2jn/1PN3IpsSJiDKoNIt5TDJw6Zu0iMDiCxufWdGhq3NH1Miib/OEU1CMO+9p/qsCFV
         d6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698918863; x=1699523663;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DAzUNXtHOjlwJshj2Ydw2hInR5ITIItZb/QptLN8SqQ=;
        b=M+b3TYqf9GpM0i/tuHPQRVy/INF4ZGi9fjKSmqWv8t5pvo57W4BGdlntSJ6cQ4fXa+
         x6NZ15mT7PeNww64zZwplMO2np2Z6B6xZRfwBENQMQDNi8CcGfqo/5wnb9cck4JuEpUq
         JAsi5pmJKAoCMyLyBnSwU9T1qaazBCE1LYHfAHd47AzUVGICt5/Dwi1FL98PjqVSIR3s
         t+lXkSCtKpXXyTXNwGW6oCMKpURjqA7XywDHfvkGR4ePuVZ3tqUObTR7wjLgCNUIjEOM
         6FpwGIKGhOidVbWj0dfaCfQcpchNe+wmMhrPr2Og7gBLMEfc+N+sLNTMci1Ros7EOiNz
         6Zcg==
X-Gm-Message-State: AOJu0YybzXMHFnGgqEOAQX+Y2rbc1vktYG0Zr2JJbak07VUcqlxq9Te4
	BsjM29Gq9nvBc1/VY+5IIxg=
X-Google-Smtp-Source: AGHT+IGfwXqA25Elrf1u1H2dPo2nh+tIGiYnnhlLoxvjw7znzrZVGFcy/w3KmNe/SL/Bu5Z5n3oXAQ==
X-Received: by 2002:a5d:4ace:0:b0:32d:9fc9:d14a with SMTP id y14-20020a5d4ace000000b0032d9fc9d14amr12685269wrs.12.1698918863105;
        Thu, 02 Nov 2023 02:54:23 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id h17-20020a5d5051000000b003143867d2ebsm1956977wrt.63.2023.11.02.02.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 02:54:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 2 Nov 2023 10:54:12 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 7/7] bpf: track aligned STACK_ZERO cases as
 imprecise spilled registers
Message-ID: <ZUNxxFiM+NqLGKtQ@krava>
References: <20231031050324.1107444-1-andrii@kernel.org>
 <20231031050324.1107444-8-andrii@kernel.org>
 <CAEf4Bzbnpf-Kf+71TtwrBL2d9yyuBS3289KqtVA6cEtOQiwQjg@mail.gmail.com>
 <ZUIEmKC7H9XeEZ95@krava>
 <CAEf4BzaLXqKxwA=vJh0kjD3eB-5GTL_D8PrShuKg7h78c_VcDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaLXqKxwA=vJh0kjD3eB-5GTL_D8PrShuKg7h78c_VcDA@mail.gmail.com>

On Wed, Nov 01, 2023 at 09:27:21AM -0700, Andrii Nakryiko wrote:
> On Wed, Nov 1, 2023 at 12:56 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Oct 30, 2023 at 10:22:48PM -0700, Andrii Nakryiko wrote:
> > > On Mon, Oct 30, 2023 at 10:03 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> > > >
> > > > Now that precision backtracing is supporting register spill/fill to/from
> > > > stack, there is another oportunity to be exploited here: minimizing
> > > > precise STACK_ZERO cases. With a simple code change we can rely on
> > > > initially imprecise register spill tracking for cases when register
> > > > spilled to stack was a known zero.
> > > >
> > > > This is a very common case for initializing on the stack variables,
> > > > including rather large structures. Often times zero has no special
> > > > meaning for the subsequent BPF program logic and is often overwritten
> > > > with non-zero values soon afterwards. But due to STACK_ZERO vs
> > > > STACK_MISC tracking, such initial zero initialization actually causes
> > > > duplication of verifier states as STACK_ZERO is clearly different than
> > > > STACK_MISC or spilled SCALAR_VALUE register.
> > > >
> > > > The effect of this (now) trivial change is huge, as can be seen below.
> > > > These are differences between BPF selftests, Cilium, and Meta-internal
> > > > BPF object files relative to previous patch in this series. You can see
> > > > improvements ranging from single-digit percentage improvement for
> > > > instructions and states, all the way to 50-60% reduction for some of
> > > > Meta-internal host agent programs, and even some Cilium programs.
> > > >
> > > > For Meta-internal ones I left only the differences for largest BPF
> > > > object files by states/instructions, as there were too many differences
> > > > in the overall output. All the differences were improvements, reducting
> > > > number of states and thus instructions validated.
> > > >
> > > > Note, Meta-internal BPF object file names are not printed below.
> > > > Many copies of balancer_ingress are actually many different
> > > > configurations of Katran, so they are different BPF programs, which
> > > > explains state reduction going from -16% all the way to 31%, depending
> > > > on BPF program logic complexity.
> > > >
> > > > SELFTESTS
> > > > =========
> > > > File                                     Program                  Insns (A)  Insns (B)  Insns    (DIFF)  States (A)  States (B)  States (DIFF)
> > > > ---------------------------------------  -----------------------  ---------  ---------  ---------------  ----------  ----------  -------------
> > > > bpf_iter_netlink.bpf.linked3.o           dump_netlink                   148        104    -44 (-29.73%)           8           5   -3 (-37.50%)
> > > > bpf_iter_unix.bpf.linked3.o              dump_unix                     8474       8404     -70 (-0.83%)         151         147    -4 (-2.65%)
> > > > bpf_loop.bpf.linked3.o                   stack_check                    560        324   -236 (-42.14%)          42          24  -18 (-42.86%)
> > > > local_storage_bench.bpf.linked3.o        get_local                      120         77    -43 (-35.83%)           9           6   -3 (-33.33%)
> > > > loop6.bpf.linked3.o                      trace_virtqueue_add_sgs      10167       9868    -299 (-2.94%)         226         206   -20 (-8.85%)
> > > > pyperf600_bpf_loop.bpf.linked3.o         on_event                      4872       3423  -1449 (-29.74%)         322         229  -93 (-28.88%)
> > > > strobemeta.bpf.linked3.o                 on_event                    180697     176036   -4661 (-2.58%)        4780        4734   -46 (-0.96%)
> > > > test_cls_redirect.bpf.linked3.o          cls_redirect                 65594      65401    -193 (-0.29%)        4230        4212   -18 (-0.43%)
> > > > test_global_func_args.bpf.linked3.o      test_cls                       145        136      -9 (-6.21%)          10           9   -1 (-10.00%)
> > > > test_l4lb.bpf.linked3.o                  balancer_ingress              4760       2612  -2148 (-45.13%)         113         102   -11 (-9.73%)
> > > > test_l4lb_noinline.bpf.linked3.o         balancer_ingress              4845       4877     +32 (+0.66%)         219         221    +2 (+0.91%)
> > > > test_l4lb_noinline_dynptr.bpf.linked3.o  balancer_ingress              2072       2087     +15 (+0.72%)          97          98    +1 (+1.03%)
> > > > test_seg6_loop.bpf.linked3.o             __add_egr_x                  12440       9975  -2465 (-19.82%)         364         353   -11 (-3.02%)
> > > > test_tcp_hdr_options.bpf.linked3.o       estab                         2558       2572     +14 (+0.55%)         179         180    +1 (+0.56%)
> > > > test_xdp_dynptr.bpf.linked3.o            _xdp_tx_iptunnel               645        596     -49 (-7.60%)          26          24    -2 (-7.69%)
> > > > test_xdp_noinline.bpf.linked3.o          balancer_ingress_v6           3520       3516      -4 (-0.11%)         216         216    +0 (+0.00%)
> > > > xdp_synproxy_kern.bpf.linked3.o          syncookie_tc                 82661      81241   -1420 (-1.72%)        5073        5155   +82 (+1.62%)
> > > > xdp_synproxy_kern.bpf.linked3.o          syncookie_xdp                84964      82297   -2667 (-3.14%)        5130        5157   +27 (+0.53%)
> > > >
> > > > META-INTERNAL
> > > > =============
> > > > Program                                 Insns (A)  Insns (B)  Insns      (DIFF)  States (A)  States (B)  States   (DIFF)
> > > > --------------------------------------  ---------  ---------  -----------------  ----------  ----------  ---------------
> > > > balancer_ingress                            27925      23608    -4317 (-15.46%)        1488        1482      -6 (-0.40%)
> > > > balancer_ingress                            31824      27546    -4278 (-13.44%)        1658        1652      -6 (-0.36%)
> > > > balancer_ingress                            32213      27935    -4278 (-13.28%)        1689        1683      -6 (-0.36%)
> > > > balancer_ingress                            32213      27935    -4278 (-13.28%)        1689        1683      -6 (-0.36%)
> > > > balancer_ingress                            31824      27546    -4278 (-13.44%)        1658        1652      -6 (-0.36%)
> > > > balancer_ingress                            38647      29562    -9085 (-23.51%)        2069        1835   -234 (-11.31%)
> > > > balancer_ingress                            38647      29562    -9085 (-23.51%)        2069        1835   -234 (-11.31%)
> > > > balancer_ingress                            40339      30792    -9547 (-23.67%)        2193        1934   -259 (-11.81%)
> > > > balancer_ingress                            37321      29055    -8266 (-22.15%)        1972        1795    -177 (-8.98%)
> > > > balancer_ingress                            38176      29753    -8423 (-22.06%)        2008        1831    -177 (-8.81%)
> > > > balancer_ingress                            29193      20910    -8283 (-28.37%)        1599        1422   -177 (-11.07%)
> > > > balancer_ingress                            30013      21452    -8561 (-28.52%)        1645        1447   -198 (-12.04%)
> > > > balancer_ingress                            28691      24290    -4401 (-15.34%)        1545        1531     -14 (-0.91%)
> > > > balancer_ingress                            34223      28965    -5258 (-15.36%)        1984        1875    -109 (-5.49%)
> > > > balancer_ingress                            35481      26158    -9323 (-26.28%)        2095        1806   -289 (-13.79%)
> > > > balancer_ingress                            35481      26158    -9323 (-26.28%)        2095        1806   -289 (-13.79%)
> > > > balancer_ingress                            35868      26455    -9413 (-26.24%)        2140        1827   -313 (-14.63%)
> > > > balancer_ingress                            35868      26455    -9413 (-26.24%)        2140        1827   -313 (-14.63%)
> > > > balancer_ingress                            35481      26158    -9323 (-26.28%)        2095        1806   -289 (-13.79%)
> > > > balancer_ingress                            35481      26158    -9323 (-26.28%)        2095        1806   -289 (-13.79%)
> > > > balancer_ingress                            34844      29485    -5359 (-15.38%)        2036        1918    -118 (-5.80%)
> > > > fbflow_egress                                3256       2652     -604 (-18.55%)         218         192    -26 (-11.93%)
> > > > fbflow_ingress                               1026        944       -82 (-7.99%)          70          63     -7 (-10.00%)
> > > > sslwall_tc_egress                            8424       7360    -1064 (-12.63%)         498         458     -40 (-8.03%)
> > > > syar_accept_protect                         15040       9539    -5501 (-36.58%)         364         220   -144 (-39.56%)
> > > > syar_connect_tcp_v6                         15036       9535    -5501 (-36.59%)         360         216   -144 (-40.00%)
> > > > syar_connect_udp_v4                         15039       9538    -5501 (-36.58%)         361         217   -144 (-39.89%)
> > > > syar_connect_connect4_protect4              24805      15833    -8972 (-36.17%)         756         480   -276 (-36.51%)
> > > > syar_lsm_file_open                         167772     151813    -15959 (-9.51%)        1836        1667    -169 (-9.20%)
> > > > syar_namespace_create_new                   14805       9304    -5501 (-37.16%)         353         209   -144 (-40.79%)
> > > > syar_python3_detect                         17531      12030    -5501 (-31.38%)         391         247   -144 (-36.83%)
> > > > syar_ssh_post_fork                          16412      10911    -5501 (-33.52%)         405         261   -144 (-35.56%)
> > > > syar_enter_execve                           14728       9227    -5501 (-37.35%)         345         201   -144 (-41.74%)
> > > > syar_enter_execveat                         14728       9227    -5501 (-37.35%)         345         201   -144 (-41.74%)
> > > > syar_exit_execve                            16622      11121    -5501 (-33.09%)         376         232   -144 (-38.30%)
> > > > syar_exit_execveat                          16622      11121    -5501 (-33.09%)         376         232   -144 (-38.30%)
> > > > syar_syscalls_kill                          15288       9787    -5501 (-35.98%)         398         254   -144 (-36.18%)
> > > > syar_task_enter_pivot_root                  14898       9397    -5501 (-36.92%)         357         213   -144 (-40.34%)
> > > > syar_syscalls_setreuid                      16678      11177    -5501 (-32.98%)         429         285   -144 (-33.57%)
> > > > syar_syscalls_setuid                        16678      11177    -5501 (-32.98%)         429         285   -144 (-33.57%)
> > > > syar_syscalls_process_vm_readv              14959       9458    -5501 (-36.77%)         364         220   -144 (-39.56%)
> > > > syar_syscalls_process_vm_writev             15757      10256    -5501 (-34.91%)         390         246   -144 (-36.92%)
> > > > do_uprobe                                   15519      10018    -5501 (-35.45%)         373         229   -144 (-38.61%)
> > > > edgewall                                   179715      55783  -123932 (-68.96%)       12607        3999  -8608 (-68.28%)
> > > > bictcp_state                                 7570       4131    -3439 (-45.43%)         496         269   -227 (-45.77%)
> > > > cubictcp_state                               7570       4131    -3439 (-45.43%)         496         269   -227 (-45.77%)
> > > > tcp_rate_skb_delivered                        447        272     -175 (-39.15%)          29          18    -11 (-37.93%)
> > > > kprobe__bbr_set_state                        4566       2615    -1951 (-42.73%)         209         124    -85 (-40.67%)
> > > > kprobe__bictcp_state                         4566       2615    -1951 (-42.73%)         209         124    -85 (-40.67%)
> > > > inet_sock_set_state                          1501       1337     -164 (-10.93%)          93          85      -8 (-8.60%)
> > > > tcp_retransmit_skb                           1145        981     -164 (-14.32%)          67          59     -8 (-11.94%)
> > > > tcp_retransmit_synack                        1183        951     -232 (-19.61%)          67          55    -12 (-17.91%)
> > > > bpf_tcptuner                                 1459       1187     -272 (-18.64%)          99          80    -19 (-19.19%)
> > > > tw_egress                                     801        776       -25 (-3.12%)          69          66      -3 (-4.35%)
> > > > tw_ingress                                    795        770       -25 (-3.14%)          69          66      -3 (-4.35%)
> > > > ttls_tc_ingress                             19025      19383      +358 (+1.88%)         470         465      -5 (-1.06%)
> > > > ttls_nat_egress                               490        299     -191 (-38.98%)          33          20    -13 (-39.39%)
> > > > ttls_nat_ingress                              448        285     -163 (-36.38%)          32          21    -11 (-34.38%)
> > > > tw_twfw_egress                             511127     212071  -299056 (-58.51%)       16733        8504  -8229 (-49.18%)
> > > > tw_twfw_ingress                            500095     212069  -288026 (-57.59%)       16223        8504  -7719 (-47.58%)
> > > > tw_twfw_tc_eg                              511113     212064  -299049 (-58.51%)       16732        8504  -8228 (-49.18%)
> > > > tw_twfw_tc_in                              500095     212069  -288026 (-57.59%)       16223        8504  -7719 (-47.58%)
> > > > tw_twfw_egress                              12632      12435      -197 (-1.56%)         276         260     -16 (-5.80%)
> > > > tw_twfw_ingress                             12631      12454      -177 (-1.40%)         278         261     -17 (-6.12%)
> > > > tw_twfw_tc_eg                               12595      12435      -160 (-1.27%)         274         259     -15 (-5.47%)
> > > > tw_twfw_tc_in                               12631      12454      -177 (-1.40%)         278         261     -17 (-6.12%)
> > > > tw_xdp_dump                                   266        209      -57 (-21.43%)           9           8     -1 (-11.11%)
> > > >
> > > > CILIUM
> > > > =========
> > > > File           Program                           Insns (A)  Insns (B)  Insns     (DIFF)  States (A)  States (B)  States  (DIFF)
> > > > -------------  --------------------------------  ---------  ---------  ----------------  ----------  ----------  --------------
> > > > bpf_host.o     cil_to_netdev                          6047       4578   -1469 (-24.29%)         362         249  -113 (-31.22%)
> > > > bpf_host.o     handle_lxc_traffic                     2227       1585    -642 (-28.83%)         156         103   -53 (-33.97%)
> > > > bpf_host.o     tail_handle_ipv4_from_netdev           2244       1458    -786 (-35.03%)         163         106   -57 (-34.97%)
> > > > bpf_host.o     tail_handle_nat_fwd_ipv4              21022      10479  -10543 (-50.15%)        1289         670  -619 (-48.02%)
> > > > bpf_host.o     tail_handle_nat_fwd_ipv6              15433      11375   -4058 (-26.29%)         905         643  -262 (-28.95%)
> > > > bpf_host.o     tail_ipv4_host_policy_ingress          2219       1367    -852 (-38.40%)         161          96   -65 (-40.37%)
> > > > bpf_host.o     tail_nodeport_nat_egress_ipv4         22460      19862   -2598 (-11.57%)        1469        1293  -176 (-11.98%)
> > > > bpf_host.o     tail_nodeport_nat_ingress_ipv4         5526       3534   -1992 (-36.05%)         366         243  -123 (-33.61%)
> > > > bpf_host.o     tail_nodeport_nat_ingress_ipv6         5132       4256    -876 (-17.07%)         241         219    -22 (-9.13%)
> > > > bpf_host.o     tail_nodeport_nat_ipv6_egress          3702       3542     -160 (-4.32%)         215         205    -10 (-4.65%)
> > > > bpf_lxc.o      tail_handle_nat_fwd_ipv4              21022      10479  -10543 (-50.15%)        1289         670  -619 (-48.02%)
> > > > bpf_lxc.o      tail_handle_nat_fwd_ipv6              15433      11375   -4058 (-26.29%)         905         643  -262 (-28.95%)
> > > > bpf_lxc.o      tail_ipv4_ct_egress                    5073       3374   -1699 (-33.49%)         262         172   -90 (-34.35%)
> > > > bpf_lxc.o      tail_ipv4_ct_ingress                   5093       3385   -1708 (-33.54%)         262         172   -90 (-34.35%)
> > > > bpf_lxc.o      tail_ipv4_ct_ingress_policy_only       5093       3385   -1708 (-33.54%)         262         172   -90 (-34.35%)
> > > > bpf_lxc.o      tail_ipv6_ct_egress                    4593       3878    -715 (-15.57%)         194         151   -43 (-22.16%)
> > > > bpf_lxc.o      tail_ipv6_ct_ingress                   4606       3891    -715 (-15.52%)         194         151   -43 (-22.16%)
> > > > bpf_lxc.o      tail_ipv6_ct_ingress_policy_only       4606       3891    -715 (-15.52%)         194         151   -43 (-22.16%)
> > > > bpf_lxc.o      tail_nodeport_nat_ingress_ipv4         5526       3534   -1992 (-36.05%)         366         243  -123 (-33.61%)
> > > > bpf_lxc.o      tail_nodeport_nat_ingress_ipv6         5132       4256    -876 (-17.07%)         241         219    -22 (-9.13%)
> > > > bpf_overlay.o  tail_handle_nat_fwd_ipv4              20524      10114  -10410 (-50.72%)        1271         638  -633 (-49.80%)
> > > > bpf_overlay.o  tail_nodeport_nat_egress_ipv4         22718      19490   -3228 (-14.21%)        1475        1275  -200 (-13.56%)
> > > > bpf_overlay.o  tail_nodeport_nat_ingress_ipv4         5526       3534   -1992 (-36.05%)         366         243  -123 (-33.61%)
> > > > bpf_overlay.o  tail_nodeport_nat_ingress_ipv6         5132       4256    -876 (-17.07%)         241         219    -22 (-9.13%)
> > > > bpf_overlay.o  tail_nodeport_nat_ipv6_egress          3638       3548      -90 (-2.47%)         209         203     -6 (-2.87%)
> > > > bpf_overlay.o  tail_rev_nodeport_lb4                  4368       3820    -548 (-12.55%)         248         215   -33 (-13.31%)
> > > > bpf_overlay.o  tail_rev_nodeport_lb6                  2867       2428    -439 (-15.31%)         167         140   -27 (-16.17%)
> > > > bpf_sock.o     cil_sock6_connect                      1718       1703      -15 (-0.87%)         100          99     -1 (-1.00%)
> > > > bpf_xdp.o      tail_handle_nat_fwd_ipv4              12917      12443     -474 (-3.67%)         875         849    -26 (-2.97%)
> > > > bpf_xdp.o      tail_handle_nat_fwd_ipv6              13515      13264     -251 (-1.86%)         715         702    -13 (-1.82%)
> > > > bpf_xdp.o      tail_lb_ipv4                          39492      36367    -3125 (-7.91%)        2430        2251   -179 (-7.37%)
> > > > bpf_xdp.o      tail_lb_ipv6                          80441      78058    -2383 (-2.96%)        3647        3523   -124 (-3.40%)
> > > > bpf_xdp.o      tail_nodeport_ipv6_dsr                 1038        901    -137 (-13.20%)          61          55     -6 (-9.84%)
> > > > bpf_xdp.o      tail_nodeport_nat_egress_ipv4         13027      12096     -931 (-7.15%)         868         809    -59 (-6.80%)
> > > > bpf_xdp.o      tail_nodeport_nat_ingress_ipv4         7617       5900   -1717 (-22.54%)         522         413  -109 (-20.88%)
> > > > bpf_xdp.o      tail_nodeport_nat_ingress_ipv6         7575       7395     -180 (-2.38%)         383         374     -9 (-2.35%)
> > > > bpf_xdp.o      tail_rev_nodeport_lb4                  6808       6739      -69 (-1.01%)         403         396     -7 (-1.74%)
> > > > bpf_xdp.o      tail_rev_nodeport_lb6                 16173      15847     -326 (-2.02%)        1010         990    -20 (-1.98%)
> > > >
> > >
> > > So I also want to mention that while I did spot check a few programs
> > > (not the biggest ones) and they did seem to have correct verification
> > > flow, I obviously can't easily validate verifier log_level=2 logs for
> > > all of the changes above, especially those multi-thousand state
> > > programs. I'd really appreciate someone from Isovalent/Cilium to do
> > > some checking of the Cilium program or two for sanity, just in case.
> > > Thanks!
> >
> > fyi, I was curious so tried that on top of tetragon programs,
> > seems up and down, but verification time is mostly lower ;-)
> >
> 
> Nice! Can you please regenerate results and sort by either insn_diff
> (absolute difference, not percentage), or states_diff? It would be
> easier to see top10 improvement and regression that way. Percentages
> by themselves can be misleading.
> 
> Oh, and peak states are probably not that useful, so maybe just use
> `-e file,prog,duration,insns,states -s insns_diff`?

$ veristat --compare ./veristat.old ./veristat.new -e file,prog,duration,insns,states --sort insns_diff

File                            Program                        Duration (us) (A)  Duration (us) (B)  Duration (us) (DIFF)  Insns (A)  Insns (B)  Insns     (DIFF)  States (A)  States (B)  States   (DIFF)
------------------------------  -----------------------------  -----------------  -----------------  --------------------  ---------  ---------  ----------------  ----------  ----------  ---------------
bpf_generic_kprobe_v61.o        generic_kprobe_process_event4              11141              12815       +1674 (+15.03%)      58981      74350  +15369 (+26.06%)        1292        1522   +230 (+17.80%)
bpf_multi_kprobe_v61.o          generic_kprobe_process_event4              14745              14029         -716 (-4.86%)      58981      74350  +15369 (+26.06%)        1292        1522   +230 (+17.80%)
bpf_generic_kprobe_v53.o        generic_kprobe_process_event4             106100             111486        +5386 (+5.08%)     296244     308555   +12311 (+4.16%)       16249       16386    +137 (+0.84%)
bpf_multi_kprobe_v53.o          generic_kprobe_process_event4             121800             111903        -9897 (-8.13%)     296244     308555   +12311 (+4.16%)       16249       16386    +137 (+0.84%)
bpf_generic_kprobe_v61.o        generic_kprobe_process_event3              13016              15029       +2013 (+15.47%)      68447      75715   +7268 (+10.62%)        1477        1565     +88 (+5.96%)
bpf_multi_kprobe_v61.o          generic_kprobe_process_event3              14824              13829         -995 (-6.71%)      68447      75715   +7268 (+10.62%)        1477        1565     +88 (+5.96%)
bpf_generic_kprobe_v61.o        generic_kprobe_process_event1              12683              14576       +1893 (+14.93%)      68450      75716   +7266 (+10.62%)        1477        1566     +89 (+6.03%)
bpf_multi_kprobe_v61.o          generic_kprobe_process_event1              16763              13670       -3093 (-18.45%)      68450      75716   +7266 (+10.62%)        1477        1566     +89 (+6.03%)
bpf_generic_kprobe_v61.o        generic_kprobe_process_event2              12822              14709       +1887 (+14.72%)      68450      75715   +7265 (+10.61%)        1477        1566     +89 (+6.03%)
bpf_multi_kprobe_v61.o          generic_kprobe_process_event2              14321              14000         -321 (-2.24%)      68450      75715   +7265 (+10.61%)        1477        1566     +89 (+6.03%)
bpf_generic_kprobe_v53.o        generic_kprobe_process_event1             108349             106105        -2244 (-2.07%)     313458     315263    +1805 (+0.58%)       16524       16544     +20 (+0.12%)
bpf_generic_kprobe_v53.o        generic_kprobe_process_event2             109991             105951        -4040 (-3.67%)     313458     315263    +1805 (+0.58%)       16524       16544     +20 (+0.12%)
bpf_generic_kprobe_v53.o        generic_kprobe_process_event3             110279             109525         -754 (-0.68%)     313455     315260    +1805 (+0.58%)       16524       16544     +20 (+0.12%)
bpf_multi_kprobe_v53.o          generic_kprobe_process_event1             132058             106791      -25267 (-19.13%)     313458     315263    +1805 (+0.58%)       16524       16544     +20 (+0.12%)
bpf_multi_kprobe_v53.o          generic_kprobe_process_event2             122505             106459      -16046 (-13.10%)     313458     315263    +1805 (+0.58%)       16524       16544     +20 (+0.12%)
bpf_multi_kprobe_v53.o          generic_kprobe_process_event3             127258             106633      -20625 (-16.21%)     313455     315260    +1805 (+0.58%)       16524       16544     +20 (+0.12%)
bpf_cgroup_mkdir.o              tg_tp_cgrp_mkdir                             206                190          -16 (-7.77%)        581        581       +0 (+0.00%)          24          24      +0 (+0.00%)
bpf_cgroup_release.o            tg_tp_cgrp_release                           114                104          -10 (-8.77%)        381        381       +0 (+0.00%)          13          13      +0 (+0.00%)
bpf_cgroup_rmdir.o              tg_tp_cgrp_rmdir                             126                121           -5 (-3.97%)        381        381       +0 (+0.00%)          13          13      +0 (+0.00%)
bpf_execve_bprm_commit_creds.o  tg_kp_bprm_committing_creds                  100                 95           -5 (-5.00%)        163        163       +0 (+0.00%)          14          14      +0 (+0.00%)
bpf_execve_event.o              execve_send                                   93                 57         -36 (-38.71%)         82         82       +0 (+0.00%)           6           6      +0 (+0.00%)
bpf_execve_event_v53.o          execve_send                                   52                 54           +2 (+3.85%)        105        105       +0 (+0.00%)           5           5      +0 (+0.00%)
bpf_execve_event_v61.o          execve_send                                   66                 69           +3 (+4.55%)        105        105       +0 (+0.00%)           5           5      +0 (+0.00%)
bpf_exit.o                      event_exit                                    65                 53         -12 (-18.46%)         94         94       +0 (+0.00%)           8           8      +0 (+0.00%)
bpf_fork.o                      event_wake_up_new_task                       179                209         +30 (+16.76%)        514        514       +0 (+0.00%)          30          30      +0 (+0.00%)
bpf_generic_kprobe.o            generic_fmodret_override                      67                 70           +3 (+4.48%)         18         18       +0 (+0.00%)           2           2      +0 (+0.00%)
bpf_generic_kprobe.o            generic_kprobe_actions                      2386               1893        -493 (-20.66%)       6746       6746       +0 (+0.00%)         287         287      +0 (+0.00%)
bpf_generic_kprobe.o            generic_kprobe_event                         302                306           +4 (+1.32%)        580        580       +0 (+0.00%)          47          47      +0 (+0.00%)
bpf_generic_kprobe.o            generic_kprobe_filter_arg1                  2679               2464         -215 (-8.03%)       6966       6966       +0 (+0.00%)         451         451      +0 (+0.00%)
bpf_generic_kprobe.o            generic_kprobe_filter_arg2                  2487               2777        +290 (+11.66%)       6966       6966       +0 (+0.00%)         451         451      +0 (+0.00%)
bpf_generic_kprobe.o            generic_kprobe_filter_arg3                  2905               2620         -285 (-9.81%)       6966       6966       +0 (+0.00%)         451         451      +0 (+0.00%)
bpf_generic_kprobe.o            generic_kprobe_filter_arg4                  2834               2706         -128 (-4.52%)       6966       6966       +0 (+0.00%)         451         451      +0 (+0.00%)
bpf_generic_kprobe.o            generic_kprobe_filter_arg5                  2771               2621         -150 (-5.41%)       6966       6966       +0 (+0.00%)         451         451      +0 (+0.00%)
bpf_generic_kprobe.o            generic_kprobe_output                         44                 41           -3 (-6.82%)         29         29       +0 (+0.00%)           2           2      +0 (+0.00%)
bpf_generic_kprobe.o            generic_kprobe_override                       40                 39           -1 (-2.50%)         20         20       +0 (+0.00%)           2           2      +0 (+0.00%)
bpf_generic_kprobe_v53.o        generic_fmodret_override                      64                 66           +2 (+3.12%)         18         18       +0 (+0.00%)           2           2      +0 (+0.00%)
bpf_generic_kprobe_v53.o        generic_kprobe_actions                     23258              14115       -9143 (-39.31%)      42545      42545       +0 (+0.00%)        1434        1434      +0 (+0.00%)
bpf_generic_kprobe_v53.o        generic_kprobe_event                         298                303           +5 (+1.68%)        583        583       +0 (+0.00%)          47          47      +0 (+0.00%)
bpf_generic_kprobe_v53.o        generic_kprobe_output                        119                148         +29 (+24.37%)        252        252       +0 (+0.00%)          19          19      +0 (+0.00%)
bpf_generic_kprobe_v53.o        generic_kprobe_override                       38                 39           +1 (+2.63%)         20         20       +0 (+0.00%)           2           2      +0 (+0.00%)
bpf_generic_kprobe_v61.o        generic_fmodret_override                      94                 89           -5 (-5.32%)         18         18       +0 (+0.00%)           2           2      +0 (+0.00%)
bpf_generic_kprobe_v61.o        generic_kprobe_actions                     15903              15072         -831 (-5.23%)      42545      42545       +0 (+0.00%)        1434        1434      +0 (+0.00%)
bpf_generic_kprobe_v61.o        generic_kprobe_event                         303                340         +37 (+12.21%)        583        583       +0 (+0.00%)          47          47      +0 (+0.00%)
bpf_generic_kprobe_v61.o        generic_kprobe_output                        153                149           -4 (-2.61%)        252        252       +0 (+0.00%)          19          19      +0 (+0.00%)
bpf_generic_kprobe_v61.o        generic_kprobe_override                       56                 51           -5 (-8.93%)         20         20       +0 (+0.00%)           2           2      +0 (+0.00%)
bpf_generic_tracepoint.o        generic_tracepoint_actions                  2259               1998        -261 (-11.55%)       6692       6692       +0 (+0.00%)         295         295      +0 (+0.00%)
bpf_generic_tracepoint.o        generic_tracepoint_arg1                     2523               2569          +46 (+1.82%)       6966       6966       +0 (+0.00%)         451         451      +0 (+0.00%)
bpf_generic_tracepoint.o        generic_tracepoint_arg2                     2853               2692         -161 (-5.64%)       6966       6966       +0 (+0.00%)         451         451      +0 (+0.00%)
bpf_generic_tracepoint.o        generic_tracepoint_arg3                     2522               2902        +380 (+15.07%)       6966       6966       +0 (+0.00%)         451         451      +0 (+0.00%)
bpf_generic_tracepoint.o        generic_tracepoint_arg4                     2538               2837        +299 (+11.78%)       6966       6966       +0 (+0.00%)         451         451      +0 (+0.00%)
bpf_generic_tracepoint.o        generic_tracepoint_arg5                     2598               2640          +42 (+1.62%)       6966       6966       +0 (+0.00%)         451         451      +0 (+0.00%)
bpf_generic_tracepoint.o        generic_tracepoint_event                     691                617         -74 (-10.71%)       1487       1487       +0 (+0.00%)          92          92      +0 (+0.00%)
bpf_generic_tracepoint.o        generic_tracepoint_output                     41                 36          -5 (-12.20%)         29         29       +0 (+0.00%)           2           2      +0 (+0.00%)
bpf_generic_tracepoint_v53.o    generic_tracepoint_actions                 15139              14536         -603 (-3.98%)      41191      41191       +0 (+0.00%)        1397        1397      +0 (+0.00%)
bpf_generic_tracepoint_v53.o    generic_tracepoint_event                     581                591          +10 (+1.72%)       1490       1490       +0 (+0.00%)          92          92      +0 (+0.00%)
bpf_generic_tracepoint_v53.o    generic_tracepoint_output                    136                136           +0 (+0.00%)        252        252       +0 (+0.00%)          19          19      +0 (+0.00%)
bpf_generic_tracepoint_v61.o    generic_tracepoint_actions                 16298              14731        -1567 (-9.61%)      41191      41191       +0 (+0.00%)        1397        1397      +0 (+0.00%)
bpf_generic_tracepoint_v61.o    generic_tracepoint_event                     555                531          -24 (-4.32%)       1490       1490       +0 (+0.00%)          92          92      +0 (+0.00%)
bpf_generic_tracepoint_v61.o    generic_tracepoint_output                    120                141         +21 (+17.50%)        252        252       +0 (+0.00%)          19          19      +0 (+0.00%)
bpf_generic_uprobe.o            generic_uprobe_actions                      1767               1928         +161 (+9.11%)       5702       5702       +0 (+0.00%)         248         248      +0 (+0.00%)
bpf_generic_uprobe.o            generic_uprobe_event                         232                207         -25 (-10.78%)        429        429       +0 (+0.00%)          33          33      +0 (+0.00%)
bpf_generic_uprobe.o            generic_uprobe_filter_arg1                  2764               2832          +68 (+2.46%)       6966       6966       +0 (+0.00%)         451         451      +0 (+0.00%)
bpf_generic_uprobe.o            generic_uprobe_filter_arg2                  2639               2675          +36 (+1.36%)       6966       6966       +0 (+0.00%)         451         451      +0 (+0.00%)
bpf_generic_uprobe.o            generic_uprobe_filter_arg3                  3875               2529       -1346 (-34.74%)       6966       6966       +0 (+0.00%)         451         451      +0 (+0.00%)
bpf_generic_uprobe.o            generic_uprobe_filter_arg4                  2646               2540         -106 (-4.01%)       6966       6966       +0 (+0.00%)         451         451      +0 (+0.00%)
bpf_generic_uprobe.o            generic_uprobe_filter_arg5                  2510               2674         +164 (+6.53%)       6966       6966       +0 (+0.00%)         451         451      +0 (+0.00%)
bpf_generic_uprobe.o            generic_uprobe_output                         41                 39           -2 (-4.88%)         29         29       +0 (+0.00%)           2           2      +0 (+0.00%)
bpf_generic_uprobe_v53.o        generic_uprobe_actions                     14216              14310          +94 (+0.66%)      39443      39443       +0 (+0.00%)        1336        1336      +0 (+0.00%)
bpf_generic_uprobe_v53.o        generic_uprobe_event                         236                223          -13 (-5.51%)        433        433       +0 (+0.00%)          33          33      +0 (+0.00%)
bpf_generic_uprobe_v53.o        generic_uprobe_output                        148                144           -4 (-2.70%)        252        252       +0 (+0.00%)          19          19      +0 (+0.00%)
bpf_generic_uprobe_v61.o        generic_uprobe_actions                     14050              14958         +908 (+6.46%)      39443      39443       +0 (+0.00%)        1336        1336      +0 (+0.00%)
bpf_generic_uprobe_v61.o        generic_uprobe_event                         241                309         +68 (+28.22%)        433        433       +0 (+0.00%)          33          33      +0 (+0.00%)
bpf_generic_uprobe_v61.o        generic_uprobe_output                        138                146           +8 (+5.80%)        252        252       +0 (+0.00%)          19          19      +0 (+0.00%)
bpf_globals.o                   read_globals_test                              0                  0           +0 (+0.00%)          0          0       +0 (+0.00%)           0           0      +0 (+0.00%)
bpf_killer.o                    killer                                        27                 28           +1 (+3.70%)         33         33       +0 (+0.00%)           3           3      +0 (+0.00%)
bpf_loader.o                    loader_kprobe                                 84                 82           -2 (-2.38%)        144        144       +0 (+0.00%)          10          10      +0 (+0.00%)
bpf_lseek.o                     test_lseek                                    54                 41         -13 (-24.07%)         67         67       +0 (+0.00%)           2           2      +0 (+0.00%)
bpf_multi_killer.o              killer                                        22                 22           +0 (+0.00%)         33         33       +0 (+0.00%)           3           3      +0 (+0.00%)
bpf_multi_kprobe_v53.o          generic_fmodret_override                     108                 73         -35 (-32.41%)         18         18       +0 (+0.00%)           2           2      +0 (+0.00%)
bpf_multi_kprobe_v53.o          generic_kprobe_actions                     29346              14095      -15251 (-51.97%)      42545      42545       +0 (+0.00%)        1434        1434      +0 (+0.00%)
bpf_multi_kprobe_v53.o          generic_kprobe_event                         339                345           +6 (+1.77%)        585        585       +0 (+0.00%)          48          48      +0 (+0.00%)
bpf_multi_kprobe_v53.o          generic_kprobe_output                        185                128         -57 (-30.81%)        252        252       +0 (+0.00%)          19          19      +0 (+0.00%)
bpf_multi_kprobe_v53.o          generic_kprobe_override                       62                 41         -21 (-33.87%)         20         20       +0 (+0.00%)           2           2      +0 (+0.00%)
bpf_multi_kprobe_v61.o          generic_fmodret_override                      71                 91         +20 (+28.17%)         18         18       +0 (+0.00%)           2           2      +0 (+0.00%)
bpf_multi_kprobe_v61.o          generic_kprobe_actions                     16654              15088        -1566 (-9.40%)      42545      42545       +0 (+0.00%)        1434        1434      +0 (+0.00%)
bpf_multi_kprobe_v61.o          generic_kprobe_event                         517                278        -239 (-46.23%)        585        585       +0 (+0.00%)          48          48      +0 (+0.00%)
bpf_multi_kprobe_v61.o          generic_kprobe_output                        153                150           -3 (-1.96%)        252        252       +0 (+0.00%)          19          19      +0 (+0.00%)
bpf_multi_kprobe_v61.o          generic_kprobe_override                       40                 51         +11 (+27.50%)         20         20       +0 (+0.00%)           2           2      +0 (+0.00%)
bpf_generic_tracepoint_v53.o    generic_tracepoint_event4                  97822              89913        -7909 (-8.09%)     215757     215704      -53 (-0.02%)       14951       14942      -9 (-0.06%)
bpf_generic_uprobe_v53.o        generic_uprobe_process_event4              99896              96233        -3663 (-3.67%)     215757     215704      -53 (-0.02%)       14951       14942      -9 (-0.06%)
bpf_generic_kprobe.o            generic_kprobe_process_event3               7581               7024         -557 (-7.35%)      19779      19680      -99 (-0.50%)        1348        1338     -10 (-0.74%)
bpf_generic_tracepoint.o        generic_tracepoint_event3                   7296               7587         +291 (+3.99%)      19779      19680      -99 (-0.50%)        1348        1338     -10 (-0.74%)
bpf_generic_tracepoint_v53.o    generic_tracepoint_event0                  94250              96057        +1807 (+1.92%)     215685     215586      -99 (-0.05%)       14954       14938     -16 (-0.11%)
bpf_generic_tracepoint_v53.o    generic_tracepoint_event1                  93947              95801        +1854 (+1.97%)     215701     215602      -99 (-0.05%)       14955       14941     -14 (-0.09%)
bpf_generic_tracepoint_v53.o    generic_tracepoint_event2                  96306              95407         -899 (-0.93%)     215701     215602      -99 (-0.05%)       14955       14941     -14 (-0.09%)
bpf_generic_tracepoint_v53.o    generic_tracepoint_event3                  97718              90734        -6984 (-7.15%)     215698     215599      -99 (-0.05%)       14955       14941     -14 (-0.09%)
bpf_generic_uprobe.o            generic_uprobe_process_event3               8127               6999       -1128 (-13.88%)      19779      19680      -99 (-0.50%)        1348        1338     -10 (-0.74%)
bpf_generic_uprobe_v53.o        generic_uprobe_process_event1             104517              90211      -14306 (-13.69%)     215701     215602      -99 (-0.05%)       14955       14941     -14 (-0.09%)
bpf_generic_uprobe_v53.o        generic_uprobe_process_event2             101025              90027      -10998 (-10.89%)     215701     215602      -99 (-0.05%)       14955       14941     -14 (-0.09%)
bpf_generic_uprobe_v53.o        generic_uprobe_process_event3              99776              95596        -4180 (-4.19%)     215698     215599      -99 (-0.05%)       14955       14941     -14 (-0.09%)
bpf_generic_kprobe.o            generic_kprobe_process_event1               7239               7468         +229 (+3.16%)      19782      19681     -101 (-0.51%)        1348        1339      -9 (-0.67%)
bpf_generic_tracepoint.o        generic_tracepoint_event1                   7347               9822       +2475 (+33.69%)      19782      19681     -101 (-0.51%)        1348        1339      -9 (-0.67%)
bpf_generic_uprobe.o            generic_uprobe_process_event1               8326               8041         -285 (-3.42%)      19782      19681     -101 (-0.51%)        1348        1339      -9 (-0.67%)
bpf_generic_kprobe.o            generic_kprobe_process_event2               7415               7691         +276 (+3.72%)      19782      19680     -102 (-0.52%)        1348        1339      -9 (-0.67%)
bpf_generic_kprobe.o            generic_kprobe_process_event4               8016               7572         -444 (-5.54%)      19760      19658     -102 (-0.52%)        1355        1344     -11 (-0.81%)
bpf_generic_tracepoint.o        generic_tracepoint_event2                   7218               7804         +586 (+8.12%)      19782      19680     -102 (-0.52%)        1348        1339      -9 (-0.67%)
bpf_generic_tracepoint.o        generic_tracepoint_event4                   7215               8109        +894 (+12.39%)      19760      19658     -102 (-0.52%)        1355        1344     -11 (-0.81%)
bpf_generic_uprobe.o            generic_uprobe_process_event2               8183               7016       -1167 (-14.26%)      19782      19680     -102 (-0.52%)        1348        1339      -9 (-0.67%)
bpf_generic_uprobe.o            generic_uprobe_process_event4               8072               7185        -887 (-10.99%)      19760      19658     -102 (-0.52%)        1355        1344     -11 (-0.81%)
bpf_generic_tracepoint.o        generic_tracepoint_event0                   7566               8026         +460 (+6.08%)      20592      20479     -113 (-0.55%)        1421        1409     -12 (-0.84%)
bpf_generic_kprobe_v53.o        generic_kprobe_process_event0             102334             101040        -1294 (-1.26%)     283295     283172     -123 (-0.04%)       16044       16033     -11 (-0.07%)
bpf_multi_kprobe_v53.o          generic_kprobe_process_event0             113628             100702      -12926 (-11.38%)     283295     283172     -123 (-0.04%)       16044       16033     -11 (-0.07%)
bpf_generic_uprobe.o            generic_uprobe_process_event0               7804               8154         +350 (+4.48%)      21063      20890     -173 (-0.82%)        1419        1400     -19 (-1.34%)
bpf_generic_retkprobe_v53.o     generic_retkprobe_event                   108357             105058        -3299 (-3.04%)     231680     231505     -175 (-0.08%)       16131       16113     -18 (-0.11%)
bpf_multi_retkprobe_v53.o       generic_retkprobe_event                   127625             110224      -17401 (-13.63%)     231631     231456     -175 (-0.08%)       16130       16112     -18 (-0.11%)
bpf_generic_retkprobe_v61.o     generic_retkprobe_event                    10694              11197         +503 (+4.70%)      24960      24775     -185 (-0.74%)        1854        1842     -12 (-0.65%)
bpf_generic_uprobe_v53.o        generic_uprobe_process_event0             103254              90496      -12758 (-12.36%)     215852     215620     -232 (-0.11%)       14972       14952     -20 (-0.13%)
bpf_generic_uprobe_v61.o        generic_uprobe_process_event0               2194               2133          -61 (-2.78%)       4395       4152     -243 (-5.53%)         329         312     -17 (-5.17%)
bpf_generic_tracepoint_v61.o    generic_tracepoint_event4                   2094               1910         -184 (-8.79%)       4396       4124     -272 (-6.19%)         323         304     -19 (-5.88%)
bpf_generic_uprobe_v61.o        generic_uprobe_process_event4               1950               2031          +81 (+4.15%)       4396       4124     -272 (-6.19%)         323         304     -19 (-5.88%)
bpf_generic_retkprobe.o         generic_retkprobe_event                    11526              11239         -287 (-2.49%)      28282      28008     -274 (-0.97%)        1973        1949     -24 (-1.22%)
bpf_multi_retkprobe_v61.o       generic_retkprobe_event                    12110               9753       -2357 (-19.46%)      24404      24110     -294 (-1.20%)        1859        1841     -18 (-0.97%)
bpf_generic_kprobe_v53.o        generic_kprobe_filter_arg1                 25215              26076         +861 (+3.41%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_kprobe_v53.o        generic_kprobe_filter_arg2                 24813              24288         -525 (-2.12%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_kprobe_v53.o        generic_kprobe_filter_arg3                 26494              24362        -2132 (-8.05%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_kprobe_v53.o        generic_kprobe_filter_arg4                 24373              24041         -332 (-1.36%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_kprobe_v53.o        generic_kprobe_filter_arg5                 26265              24317        -1948 (-7.42%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_kprobe_v61.o        generic_kprobe_filter_arg1                 25870              24169        -1701 (-6.58%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_kprobe_v61.o        generic_kprobe_filter_arg2                 26667              24070        -2597 (-9.74%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_kprobe_v61.o        generic_kprobe_filter_arg3                 27248              24758        -2490 (-9.14%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_kprobe_v61.o        generic_kprobe_filter_arg4                 27483              26107        -1376 (-5.01%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_kprobe_v61.o        generic_kprobe_filter_arg5                 26764              26316         -448 (-1.67%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_tracepoint_v53.o    generic_tracepoint_arg1                    26569              23775       -2794 (-10.52%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_tracepoint_v53.o    generic_tracepoint_arg2                    26853              24057       -2796 (-10.41%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_tracepoint_v53.o    generic_tracepoint_arg3                    27067              24044       -3023 (-11.17%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_tracepoint_v53.o    generic_tracepoint_arg4                    24410              23953         -457 (-1.87%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_tracepoint_v53.o    generic_tracepoint_arg5                    30439              24792       -5647 (-18.55%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_tracepoint_v61.o    generic_tracepoint_arg1                    27534              23721       -3813 (-13.85%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_tracepoint_v61.o    generic_tracepoint_arg2                    28248              24052       -4196 (-14.85%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_tracepoint_v61.o    generic_tracepoint_arg3                    29118              24012       -5106 (-17.54%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_tracepoint_v61.o    generic_tracepoint_arg4                    33309              23915       -9394 (-28.20%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_tracepoint_v61.o    generic_tracepoint_arg5                    28057              24983       -3074 (-10.96%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_uprobe_v53.o        generic_uprobe_filter_arg1                 28012              26052        -1960 (-7.00%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_uprobe_v53.o        generic_uprobe_filter_arg2                 27759              26451        -1308 (-4.71%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_uprobe_v53.o        generic_uprobe_filter_arg3                 27301              25856        -1445 (-5.29%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_uprobe_v53.o        generic_uprobe_filter_arg4                 26331              26187         -144 (-0.55%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_uprobe_v53.o        generic_uprobe_filter_arg5                 27284              26122        -1162 (-4.26%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_uprobe_v61.o        generic_uprobe_filter_arg1                 30324              26943       -3381 (-11.15%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_uprobe_v61.o        generic_uprobe_filter_arg2                 26755              26758           +3 (+0.01%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_uprobe_v61.o        generic_uprobe_filter_arg3                 28337              27992         -345 (-1.22%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_uprobe_v61.o        generic_uprobe_filter_arg4                 26332              27308         +976 (+3.71%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_uprobe_v61.o        generic_uprobe_filter_arg5                 27209              26780         -429 (-1.58%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_multi_kprobe_v53.o          generic_kprobe_filter_arg1                 33490              23550       -9940 (-29.68%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_multi_kprobe_v53.o          generic_kprobe_filter_arg2                 42586              24318      -18268 (-42.90%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_multi_kprobe_v53.o          generic_kprobe_filter_arg3                 39256              24731      -14525 (-37.00%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_multi_kprobe_v53.o          generic_kprobe_filter_arg4                 41607              23955      -17652 (-42.43%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_multi_kprobe_v53.o          generic_kprobe_filter_arg5                 49382              24518      -24864 (-50.35%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_multi_kprobe_v61.o          generic_kprobe_filter_arg1                 41140              26793      -14347 (-34.87%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_multi_kprobe_v61.o          generic_kprobe_filter_arg2                 30326              26454       -3872 (-12.77%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_multi_kprobe_v61.o          generic_kprobe_filter_arg3                 38517              24452      -14065 (-36.52%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_multi_kprobe_v61.o          generic_kprobe_filter_arg4                 36157              24539      -11618 (-32.13%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_multi_kprobe_v61.o          generic_kprobe_filter_arg5                 40673              25657      -15016 (-36.92%)      91872      91575     -297 (-0.32%)        2910        2900     -10 (-0.34%)
bpf_generic_tracepoint_v61.o    generic_tracepoint_event0                   2128               2058          -70 (-3.29%)       4403       4100     -303 (-6.88%)         326         305     -21 (-6.44%)
bpf_generic_tracepoint_v61.o    generic_tracepoint_event1                   1982               2028          +46 (+2.32%)       4409       4106     -303 (-6.87%)         328         304     -24 (-7.32%)
bpf_generic_tracepoint_v61.o    generic_tracepoint_event2                   2357               2054        -303 (-12.86%)       4409       4106     -303 (-6.87%)         328         304     -24 (-7.32%)
bpf_generic_tracepoint_v61.o    generic_tracepoint_event3                   2018               1835         -183 (-9.07%)       4406       4103     -303 (-6.88%)         328         304     -24 (-7.32%)
bpf_generic_uprobe_v61.o        generic_uprobe_process_event1               1885               1832          -53 (-2.81%)       4409       4106     -303 (-6.87%)         328         304     -24 (-7.32%)
bpf_generic_uprobe_v61.o        generic_uprobe_process_event2               2775               1966        -809 (-29.15%)       4409       4106     -303 (-6.87%)         328         304     -24 (-7.32%)
bpf_generic_uprobe_v61.o        generic_uprobe_process_event3               3237               2004       -1233 (-38.09%)       4406       4103     -303 (-6.88%)         328         304     -24 (-7.32%)
bpf_generic_kprobe.o            generic_kprobe_process_event0               7817               7945         +128 (+1.64%)      21321      21001     -320 (-1.50%)        1440        1403     -37 (-2.57%)
bpf_execve_event.o              event_execve                               12147              12843         +696 (+5.73%)      35096      34723     -373 (-1.06%)        2278        2251     -27 (-1.19%)
bpf_execve_event_v61.o          event_execve                                6094               6059          -35 (-0.57%)      27456      26871     -585 (-2.13%)         671         636     -35 (-5.22%)
bpf_execve_event_v53.o          event_execve                               97457              98430         +973 (+1.00%)     245365     239363    -6002 (-2.45%)       15430       15334     -96 (-0.62%)
bpf_generic_kprobe_v53.o        generic_kprobe_process_filter              57465              54691        -2774 (-4.83%)     166600     158639    -7961 (-4.78%)        7263        6602    -661 (-9.10%)
bpf_generic_kprobe_v61.o        generic_kprobe_process_filter              57674              51652       -6022 (-10.44%)     166600     158639    -7961 (-4.78%)        7263        6602    -661 (-9.10%)
bpf_generic_tracepoint_v53.o    generic_tracepoint_filter                  64076              50012      -14064 (-21.95%)     166600     158639    -7961 (-4.78%)        7263        6602    -661 (-9.10%)
bpf_generic_tracepoint_v61.o    generic_tracepoint_filter                  63620              50068      -13552 (-21.30%)     166600     158639    -7961 (-4.78%)        7263        6602    -661 (-9.10%)
bpf_generic_uprobe_v53.o        generic_uprobe_process_filter              65621              56496       -9125 (-13.91%)     166600     158639    -7961 (-4.78%)        7263        6602    -661 (-9.10%)
bpf_generic_uprobe_v61.o        generic_uprobe_process_filter              62774              56727        -6047 (-9.63%)     166600     158639    -7961 (-4.78%)        7263        6602    -661 (-9.10%)
bpf_multi_kprobe_v53.o          generic_kprobe_process_filter              73918              54826      -19092 (-25.83%)     166600     158639    -7961 (-4.78%)        7263        6602    -661 (-9.10%)
bpf_multi_kprobe_v61.o          generic_kprobe_process_filter              73994              54979      -19015 (-25.70%)     166600     158639    -7961 (-4.78%)        7263        6602    -661 (-9.10%)
bpf_generic_kprobe_v61.o        generic_kprobe_process_event0              11184              10303         -881 (-7.88%)      58564      49822   -8742 (-14.93%)        1243        1108   -135 (-10.86%)
bpf_multi_kprobe_v61.o          generic_kprobe_process_event0              17270               9818       -7452 (-43.15%)      58564      49822   -8742 (-14.93%)        1243        1108   -135 (-10.86%)
bpf_generic_kprobe.o            generic_kprobe_process_filter              43093              31779      -11314 (-26.25%)      77948      66684  -11264 (-14.45%)        6048        5009  -1039 (-17.18%)
bpf_generic_tracepoint.o        generic_tracepoint_filter                  41153              33891       -7262 (-17.65%)      77948      66684  -11264 (-14.45%)        6048        5009  -1039 (-17.18%)
bpf_generic_uprobe.o            generic_uprobe_process_filter              40999              31572       -9427 (-22.99%)      77948      66684  -11264 (-14.45%)        6048        5009  -1039 (-17.18%)

