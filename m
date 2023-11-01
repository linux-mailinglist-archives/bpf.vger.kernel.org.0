Return-Path: <bpf+bounces-13808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0C57DE495
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 17:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC24C1C20DC1
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 16:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B8714F7E;
	Wed,  1 Nov 2023 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSCfD0BA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E926ABB
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 16:27:40 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738D7115
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 09:27:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so10988431a12.1
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 09:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698856054; x=1699460854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plEy4LbZKt5DNUXmLNC0UWnBwAM4hyqtIqNXLYSqs/g=;
        b=JSCfD0BABP75K0BXMiGc9xCv2kj9Ht/AcTDEgeXvFB/8JsI+NPKpg/t58W5cs9lc/7
         Uqb6CrK3bNNAKAXwNvqrmShZVRO/f5wGwJ2skhCphHVxgGcl7LMhnTOtycP3Yqjg02XV
         xFehGPZtuu9czhNV8CkT3vKlmepIC3hlMl8kNeYmgtzyzq4CZhMkCagmOpeSfQbTarqn
         AQhrxedyvJOhUA/xNcY8xFe+Ygj1OGDoXZvSVN/7gm1cleiN7QvqcXd7RQS2Nspdcnlt
         OBFTy0jS1HL88KROwbowux7Yl3OR+ujJy4JuDD7Y4Jzo6I2TUHL5OPC8kGFlVFShuXnq
         PHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698856054; x=1699460854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plEy4LbZKt5DNUXmLNC0UWnBwAM4hyqtIqNXLYSqs/g=;
        b=nW8Ve042sl0+iOfnOn2DnG5G3tVt3xaN0OvE40k6R3IJCt6aEZhA5ry/C4SjnwCGtA
         gztTU5WaTBnzZIGWE1eJpLe+eb/BmTT4HjtkMjlzZ0pVN/X2wGJj6X40gTuRAvb5LzzL
         fD7f+4of+5QBopML7YGtXJ0LUvOE5FoDpANKaIxNltUGB/SNMeNwWWZwVWaGuEogUYzO
         cVu4hbT4J/uYkRJkpEXV2jEM59lTRMSFkgMKmyqDQgs+dSPdQIqDIWaniC3jZx6vel+4
         yL7WcTV8l/xSHzd5DXZEzA7Af2DGZjrX3bQf00whoczgvmf4ON73Yg8VBB+6mGCPNDeg
         fPKg==
X-Gm-Message-State: AOJu0YywR3uKxMhpt4DffNxqJbfw5NRQoWqwIDp/Vk4MvzSJQdD+/1mX
	pHkfVxZJIneuiJQDEKtRmEbB0ipZGoD/sNhBteF7hwQH
X-Google-Smtp-Source: AGHT+IE5EeKuN6SsTTJZYyjHIeZJIGg4aKJBKDsFALEj30TO4iPrTP6gZeSHoQKld2Eim41DhOcyu+kGdL5CCFWA6Q0=
X-Received: by 2002:a17:907:3681:b0:9ae:3d17:d5d0 with SMTP id
 bi1-20020a170907368100b009ae3d17d5d0mr2172191ejc.31.1698856053549; Wed, 01
 Nov 2023 09:27:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031050324.1107444-1-andrii@kernel.org> <20231031050324.1107444-8-andrii@kernel.org>
 <CAEf4Bzbnpf-Kf+71TtwrBL2d9yyuBS3289KqtVA6cEtOQiwQjg@mail.gmail.com> <ZUIEmKC7H9XeEZ95@krava>
In-Reply-To: <ZUIEmKC7H9XeEZ95@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Nov 2023 09:27:21 -0700
Message-ID: <CAEf4BzaLXqKxwA=vJh0kjD3eB-5GTL_D8PrShuKg7h78c_VcDA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/7] bpf: track aligned STACK_ZERO cases as
 imprecise spilled registers
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 12:56=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Oct 30, 2023 at 10:22:48PM -0700, Andrii Nakryiko wrote:
> > On Mon, Oct 30, 2023 at 10:03=E2=80=AFPM Andrii Nakryiko <andrii@kernel=
.org> wrote:
> > >
> > > Now that precision backtracing is supporting register spill/fill to/f=
rom
> > > stack, there is another oportunity to be exploited here: minimizing
> > > precise STACK_ZERO cases. With a simple code change we can rely on
> > > initially imprecise register spill tracking for cases when register
> > > spilled to stack was a known zero.
> > >
> > > This is a very common case for initializing on the stack variables,
> > > including rather large structures. Often times zero has no special
> > > meaning for the subsequent BPF program logic and is often overwritten
> > > with non-zero values soon afterwards. But due to STACK_ZERO vs
> > > STACK_MISC tracking, such initial zero initialization actually causes
> > > duplication of verifier states as STACK_ZERO is clearly different tha=
n
> > > STACK_MISC or spilled SCALAR_VALUE register.
> > >
> > > The effect of this (now) trivial change is huge, as can be seen below=
.
> > > These are differences between BPF selftests, Cilium, and Meta-interna=
l
> > > BPF object files relative to previous patch in this series. You can s=
ee
> > > improvements ranging from single-digit percentage improvement for
> > > instructions and states, all the way to 50-60% reduction for some of
> > > Meta-internal host agent programs, and even some Cilium programs.
> > >
> > > For Meta-internal ones I left only the differences for largest BPF
> > > object files by states/instructions, as there were too many differenc=
es
> > > in the overall output. All the differences were improvements, reducti=
ng
> > > number of states and thus instructions validated.
> > >
> > > Note, Meta-internal BPF object file names are not printed below.
> > > Many copies of balancer_ingress are actually many different
> > > configurations of Katran, so they are different BPF programs, which
> > > explains state reduction going from -16% all the way to 31%, dependin=
g
> > > on BPF program logic complexity.
> > >
> > > SELFTESTS
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > File                                     Program                  Ins=
ns (A)  Insns (B)  Insns    (DIFF)  States (A)  States (B)  States (DIFF)
> > > ---------------------------------------  -----------------------  ---=
------  ---------  ---------------  ----------  ----------  -------------
> > > bpf_iter_netlink.bpf.linked3.o           dump_netlink                =
   148        104    -44 (-29.73%)           8           5   -3 (-37.50%)
> > > bpf_iter_unix.bpf.linked3.o              dump_unix                   =
  8474       8404     -70 (-0.83%)         151         147    -4 (-2.65%)
> > > bpf_loop.bpf.linked3.o                   stack_check                 =
   560        324   -236 (-42.14%)          42          24  -18 (-42.86%)
> > > local_storage_bench.bpf.linked3.o        get_local                   =
   120         77    -43 (-35.83%)           9           6   -3 (-33.33%)
> > > loop6.bpf.linked3.o                      trace_virtqueue_add_sgs     =
 10167       9868    -299 (-2.94%)         226         206   -20 (-8.85%)
> > > pyperf600_bpf_loop.bpf.linked3.o         on_event                    =
  4872       3423  -1449 (-29.74%)         322         229  -93 (-28.88%)
> > > strobemeta.bpf.linked3.o                 on_event                    =
180697     176036   -4661 (-2.58%)        4780        4734   -46 (-0.96%)
> > > test_cls_redirect.bpf.linked3.o          cls_redirect                =
 65594      65401    -193 (-0.29%)        4230        4212   -18 (-0.43%)
> > > test_global_func_args.bpf.linked3.o      test_cls                    =
   145        136      -9 (-6.21%)          10           9   -1 (-10.00%)
> > > test_l4lb.bpf.linked3.o                  balancer_ingress            =
  4760       2612  -2148 (-45.13%)         113         102   -11 (-9.73%)
> > > test_l4lb_noinline.bpf.linked3.o         balancer_ingress            =
  4845       4877     +32 (+0.66%)         219         221    +2 (+0.91%)
> > > test_l4lb_noinline_dynptr.bpf.linked3.o  balancer_ingress            =
  2072       2087     +15 (+0.72%)          97          98    +1 (+1.03%)
> > > test_seg6_loop.bpf.linked3.o             __add_egr_x                 =
 12440       9975  -2465 (-19.82%)         364         353   -11 (-3.02%)
> > > test_tcp_hdr_options.bpf.linked3.o       estab                       =
  2558       2572     +14 (+0.55%)         179         180    +1 (+0.56%)
> > > test_xdp_dynptr.bpf.linked3.o            _xdp_tx_iptunnel            =
   645        596     -49 (-7.60%)          26          24    -2 (-7.69%)
> > > test_xdp_noinline.bpf.linked3.o          balancer_ingress_v6         =
  3520       3516      -4 (-0.11%)         216         216    +0 (+0.00%)
> > > xdp_synproxy_kern.bpf.linked3.o          syncookie_tc                =
 82661      81241   -1420 (-1.72%)        5073        5155   +82 (+1.62%)
> > > xdp_synproxy_kern.bpf.linked3.o          syncookie_xdp               =
 84964      82297   -2667 (-3.14%)        5130        5157   +27 (+0.53%)
> > >
> > > META-INTERNAL
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Program                                 Insns (A)  Insns (B)  Insns  =
    (DIFF)  States (A)  States (B)  States   (DIFF)
> > > --------------------------------------  ---------  ---------  -------=
----------  ----------  ----------  ---------------
> > > balancer_ingress                            27925      23608    -4317=
 (-15.46%)        1488        1482      -6 (-0.40%)
> > > balancer_ingress                            31824      27546    -4278=
 (-13.44%)        1658        1652      -6 (-0.36%)
> > > balancer_ingress                            32213      27935    -4278=
 (-13.28%)        1689        1683      -6 (-0.36%)
> > > balancer_ingress                            32213      27935    -4278=
 (-13.28%)        1689        1683      -6 (-0.36%)
> > > balancer_ingress                            31824      27546    -4278=
 (-13.44%)        1658        1652      -6 (-0.36%)
> > > balancer_ingress                            38647      29562    -9085=
 (-23.51%)        2069        1835   -234 (-11.31%)
> > > balancer_ingress                            38647      29562    -9085=
 (-23.51%)        2069        1835   -234 (-11.31%)
> > > balancer_ingress                            40339      30792    -9547=
 (-23.67%)        2193        1934   -259 (-11.81%)
> > > balancer_ingress                            37321      29055    -8266=
 (-22.15%)        1972        1795    -177 (-8.98%)
> > > balancer_ingress                            38176      29753    -8423=
 (-22.06%)        2008        1831    -177 (-8.81%)
> > > balancer_ingress                            29193      20910    -8283=
 (-28.37%)        1599        1422   -177 (-11.07%)
> > > balancer_ingress                            30013      21452    -8561=
 (-28.52%)        1645        1447   -198 (-12.04%)
> > > balancer_ingress                            28691      24290    -4401=
 (-15.34%)        1545        1531     -14 (-0.91%)
> > > balancer_ingress                            34223      28965    -5258=
 (-15.36%)        1984        1875    -109 (-5.49%)
> > > balancer_ingress                            35481      26158    -9323=
 (-26.28%)        2095        1806   -289 (-13.79%)
> > > balancer_ingress                            35481      26158    -9323=
 (-26.28%)        2095        1806   -289 (-13.79%)
> > > balancer_ingress                            35868      26455    -9413=
 (-26.24%)        2140        1827   -313 (-14.63%)
> > > balancer_ingress                            35868      26455    -9413=
 (-26.24%)        2140        1827   -313 (-14.63%)
> > > balancer_ingress                            35481      26158    -9323=
 (-26.28%)        2095        1806   -289 (-13.79%)
> > > balancer_ingress                            35481      26158    -9323=
 (-26.28%)        2095        1806   -289 (-13.79%)
> > > balancer_ingress                            34844      29485    -5359=
 (-15.38%)        2036        1918    -118 (-5.80%)
> > > fbflow_egress                                3256       2652     -604=
 (-18.55%)         218         192    -26 (-11.93%)
> > > fbflow_ingress                               1026        944       -8=
2 (-7.99%)          70          63     -7 (-10.00%)
> > > sslwall_tc_egress                            8424       7360    -1064=
 (-12.63%)         498         458     -40 (-8.03%)
> > > syar_accept_protect                         15040       9539    -5501=
 (-36.58%)         364         220   -144 (-39.56%)
> > > syar_connect_tcp_v6                         15036       9535    -5501=
 (-36.59%)         360         216   -144 (-40.00%)
> > > syar_connect_udp_v4                         15039       9538    -5501=
 (-36.58%)         361         217   -144 (-39.89%)
> > > syar_connect_connect4_protect4              24805      15833    -8972=
 (-36.17%)         756         480   -276 (-36.51%)
> > > syar_lsm_file_open                         167772     151813    -1595=
9 (-9.51%)        1836        1667    -169 (-9.20%)
> > > syar_namespace_create_new                   14805       9304    -5501=
 (-37.16%)         353         209   -144 (-40.79%)
> > > syar_python3_detect                         17531      12030    -5501=
 (-31.38%)         391         247   -144 (-36.83%)
> > > syar_ssh_post_fork                          16412      10911    -5501=
 (-33.52%)         405         261   -144 (-35.56%)
> > > syar_enter_execve                           14728       9227    -5501=
 (-37.35%)         345         201   -144 (-41.74%)
> > > syar_enter_execveat                         14728       9227    -5501=
 (-37.35%)         345         201   -144 (-41.74%)
> > > syar_exit_execve                            16622      11121    -5501=
 (-33.09%)         376         232   -144 (-38.30%)
> > > syar_exit_execveat                          16622      11121    -5501=
 (-33.09%)         376         232   -144 (-38.30%)
> > > syar_syscalls_kill                          15288       9787    -5501=
 (-35.98%)         398         254   -144 (-36.18%)
> > > syar_task_enter_pivot_root                  14898       9397    -5501=
 (-36.92%)         357         213   -144 (-40.34%)
> > > syar_syscalls_setreuid                      16678      11177    -5501=
 (-32.98%)         429         285   -144 (-33.57%)
> > > syar_syscalls_setuid                        16678      11177    -5501=
 (-32.98%)         429         285   -144 (-33.57%)
> > > syar_syscalls_process_vm_readv              14959       9458    -5501=
 (-36.77%)         364         220   -144 (-39.56%)
> > > syar_syscalls_process_vm_writev             15757      10256    -5501=
 (-34.91%)         390         246   -144 (-36.92%)
> > > do_uprobe                                   15519      10018    -5501=
 (-35.45%)         373         229   -144 (-38.61%)
> > > edgewall                                   179715      55783  -123932=
 (-68.96%)       12607        3999  -8608 (-68.28%)
> > > bictcp_state                                 7570       4131    -3439=
 (-45.43%)         496         269   -227 (-45.77%)
> > > cubictcp_state                               7570       4131    -3439=
 (-45.43%)         496         269   -227 (-45.77%)
> > > tcp_rate_skb_delivered                        447        272     -175=
 (-39.15%)          29          18    -11 (-37.93%)
> > > kprobe__bbr_set_state                        4566       2615    -1951=
 (-42.73%)         209         124    -85 (-40.67%)
> > > kprobe__bictcp_state                         4566       2615    -1951=
 (-42.73%)         209         124    -85 (-40.67%)
> > > inet_sock_set_state                          1501       1337     -164=
 (-10.93%)          93          85      -8 (-8.60%)
> > > tcp_retransmit_skb                           1145        981     -164=
 (-14.32%)          67          59     -8 (-11.94%)
> > > tcp_retransmit_synack                        1183        951     -232=
 (-19.61%)          67          55    -12 (-17.91%)
> > > bpf_tcptuner                                 1459       1187     -272=
 (-18.64%)          99          80    -19 (-19.19%)
> > > tw_egress                                     801        776       -2=
5 (-3.12%)          69          66      -3 (-4.35%)
> > > tw_ingress                                    795        770       -2=
5 (-3.14%)          69          66      -3 (-4.35%)
> > > ttls_tc_ingress                             19025      19383      +35=
8 (+1.88%)         470         465      -5 (-1.06%)
> > > ttls_nat_egress                               490        299     -191=
 (-38.98%)          33          20    -13 (-39.39%)
> > > ttls_nat_ingress                              448        285     -163=
 (-36.38%)          32          21    -11 (-34.38%)
> > > tw_twfw_egress                             511127     212071  -299056=
 (-58.51%)       16733        8504  -8229 (-49.18%)
> > > tw_twfw_ingress                            500095     212069  -288026=
 (-57.59%)       16223        8504  -7719 (-47.58%)
> > > tw_twfw_tc_eg                              511113     212064  -299049=
 (-58.51%)       16732        8504  -8228 (-49.18%)
> > > tw_twfw_tc_in                              500095     212069  -288026=
 (-57.59%)       16223        8504  -7719 (-47.58%)
> > > tw_twfw_egress                              12632      12435      -19=
7 (-1.56%)         276         260     -16 (-5.80%)
> > > tw_twfw_ingress                             12631      12454      -17=
7 (-1.40%)         278         261     -17 (-6.12%)
> > > tw_twfw_tc_eg                               12595      12435      -16=
0 (-1.27%)         274         259     -15 (-5.47%)
> > > tw_twfw_tc_in                               12631      12454      -17=
7 (-1.40%)         278         261     -17 (-6.12%)
> > > tw_xdp_dump                                   266        209      -57=
 (-21.43%)           9           8     -1 (-11.11%)
> > >
> > > CILIUM
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > File           Program                           Insns (A)  Insns (B)=
  Insns     (DIFF)  States (A)  States (B)  States  (DIFF)
> > > -------------  --------------------------------  ---------  ---------=
  ----------------  ----------  ----------  --------------
> > > bpf_host.o     cil_to_netdev                          6047       4578=
   -1469 (-24.29%)         362         249  -113 (-31.22%)
> > > bpf_host.o     handle_lxc_traffic                     2227       1585=
    -642 (-28.83%)         156         103   -53 (-33.97%)
> > > bpf_host.o     tail_handle_ipv4_from_netdev           2244       1458=
    -786 (-35.03%)         163         106   -57 (-34.97%)
> > > bpf_host.o     tail_handle_nat_fwd_ipv4              21022      10479=
  -10543 (-50.15%)        1289         670  -619 (-48.02%)
> > > bpf_host.o     tail_handle_nat_fwd_ipv6              15433      11375=
   -4058 (-26.29%)         905         643  -262 (-28.95%)
> > > bpf_host.o     tail_ipv4_host_policy_ingress          2219       1367=
    -852 (-38.40%)         161          96   -65 (-40.37%)
> > > bpf_host.o     tail_nodeport_nat_egress_ipv4         22460      19862=
   -2598 (-11.57%)        1469        1293  -176 (-11.98%)
> > > bpf_host.o     tail_nodeport_nat_ingress_ipv4         5526       3534=
   -1992 (-36.05%)         366         243  -123 (-33.61%)
> > > bpf_host.o     tail_nodeport_nat_ingress_ipv6         5132       4256=
    -876 (-17.07%)         241         219    -22 (-9.13%)
> > > bpf_host.o     tail_nodeport_nat_ipv6_egress          3702       3542=
     -160 (-4.32%)         215         205    -10 (-4.65%)
> > > bpf_lxc.o      tail_handle_nat_fwd_ipv4              21022      10479=
  -10543 (-50.15%)        1289         670  -619 (-48.02%)
> > > bpf_lxc.o      tail_handle_nat_fwd_ipv6              15433      11375=
   -4058 (-26.29%)         905         643  -262 (-28.95%)
> > > bpf_lxc.o      tail_ipv4_ct_egress                    5073       3374=
   -1699 (-33.49%)         262         172   -90 (-34.35%)
> > > bpf_lxc.o      tail_ipv4_ct_ingress                   5093       3385=
   -1708 (-33.54%)         262         172   -90 (-34.35%)
> > > bpf_lxc.o      tail_ipv4_ct_ingress_policy_only       5093       3385=
   -1708 (-33.54%)         262         172   -90 (-34.35%)
> > > bpf_lxc.o      tail_ipv6_ct_egress                    4593       3878=
    -715 (-15.57%)         194         151   -43 (-22.16%)
> > > bpf_lxc.o      tail_ipv6_ct_ingress                   4606       3891=
    -715 (-15.52%)         194         151   -43 (-22.16%)
> > > bpf_lxc.o      tail_ipv6_ct_ingress_policy_only       4606       3891=
    -715 (-15.52%)         194         151   -43 (-22.16%)
> > > bpf_lxc.o      tail_nodeport_nat_ingress_ipv4         5526       3534=
   -1992 (-36.05%)         366         243  -123 (-33.61%)
> > > bpf_lxc.o      tail_nodeport_nat_ingress_ipv6         5132       4256=
    -876 (-17.07%)         241         219    -22 (-9.13%)
> > > bpf_overlay.o  tail_handle_nat_fwd_ipv4              20524      10114=
  -10410 (-50.72%)        1271         638  -633 (-49.80%)
> > > bpf_overlay.o  tail_nodeport_nat_egress_ipv4         22718      19490=
   -3228 (-14.21%)        1475        1275  -200 (-13.56%)
> > > bpf_overlay.o  tail_nodeport_nat_ingress_ipv4         5526       3534=
   -1992 (-36.05%)         366         243  -123 (-33.61%)
> > > bpf_overlay.o  tail_nodeport_nat_ingress_ipv6         5132       4256=
    -876 (-17.07%)         241         219    -22 (-9.13%)
> > > bpf_overlay.o  tail_nodeport_nat_ipv6_egress          3638       3548=
      -90 (-2.47%)         209         203     -6 (-2.87%)
> > > bpf_overlay.o  tail_rev_nodeport_lb4                  4368       3820=
    -548 (-12.55%)         248         215   -33 (-13.31%)
> > > bpf_overlay.o  tail_rev_nodeport_lb6                  2867       2428=
    -439 (-15.31%)         167         140   -27 (-16.17%)
> > > bpf_sock.o     cil_sock6_connect                      1718       1703=
      -15 (-0.87%)         100          99     -1 (-1.00%)
> > > bpf_xdp.o      tail_handle_nat_fwd_ipv4              12917      12443=
     -474 (-3.67%)         875         849    -26 (-2.97%)
> > > bpf_xdp.o      tail_handle_nat_fwd_ipv6              13515      13264=
     -251 (-1.86%)         715         702    -13 (-1.82%)
> > > bpf_xdp.o      tail_lb_ipv4                          39492      36367=
    -3125 (-7.91%)        2430        2251   -179 (-7.37%)
> > > bpf_xdp.o      tail_lb_ipv6                          80441      78058=
    -2383 (-2.96%)        3647        3523   -124 (-3.40%)
> > > bpf_xdp.o      tail_nodeport_ipv6_dsr                 1038        901=
    -137 (-13.20%)          61          55     -6 (-9.84%)
> > > bpf_xdp.o      tail_nodeport_nat_egress_ipv4         13027      12096=
     -931 (-7.15%)         868         809    -59 (-6.80%)
> > > bpf_xdp.o      tail_nodeport_nat_ingress_ipv4         7617       5900=
   -1717 (-22.54%)         522         413  -109 (-20.88%)
> > > bpf_xdp.o      tail_nodeport_nat_ingress_ipv6         7575       7395=
     -180 (-2.38%)         383         374     -9 (-2.35%)
> > > bpf_xdp.o      tail_rev_nodeport_lb4                  6808       6739=
      -69 (-1.01%)         403         396     -7 (-1.74%)
> > > bpf_xdp.o      tail_rev_nodeport_lb6                 16173      15847=
     -326 (-2.02%)        1010         990    -20 (-1.98%)
> > >
> >
> > So I also want to mention that while I did spot check a few programs
> > (not the biggest ones) and they did seem to have correct verification
> > flow, I obviously can't easily validate verifier log_level=3D2 logs for
> > all of the changes above, especially those multi-thousand state
> > programs. I'd really appreciate someone from Isovalent/Cilium to do
> > some checking of the Cilium program or two for sanity, just in case.
> > Thanks!
>
> fyi, I was curious so tried that on top of tetragon programs,
> seems up and down, but verification time is mostly lower ;-)
>

Nice! Can you please regenerate results and sort by either insn_diff
(absolute difference, not percentage), or states_diff? It would be
easier to see top10 improvement and regression that way. Percentages
by themselves can be misleading.

Oh, and peak states are probably not that useful, so maybe just use
`-e file,prog,duration,insns,states -s insns_diff`?

> jirka
>
>
> ---
> $ veristat --compare veristat.old veristat.new
>
> File                            Program                        Duration (=
us) (A)  Duration (us) (B)  Duration (us) (DIFF)  Insns (A)  Insns (B)  Ins=
ns     (DIFF)  States (A)  States (B)  States   (DIFF)  Peak states (A)  Pe=
ak states (B)  Peak states (DIFF)
> ------------------------------  -----------------------------  ----------=
-------  -----------------  --------------------  ---------  ---------  ---=
-------------  ----------  ----------  ---------------  ---------------  --=
-------------  ------------------
> bpf_cgroup_mkdir.o              tg_tp_cgrp_mkdir                         =
    206                190          -16 (-7.77%)        581        581     =
  +0 (+0.00%)          24          24      +0 (+0.00%)               24    =
           24         +0 (+0.00%)
> bpf_cgroup_release.o            tg_tp_cgrp_release                       =
    114                104          -10 (-8.77%)        381        381     =
  +0 (+0.00%)          13          13      +0 (+0.00%)               13    =
           13         +0 (+0.00%)
> bpf_cgroup_rmdir.o              tg_tp_cgrp_rmdir                         =
    126                121           -5 (-3.97%)        381        381     =
  +0 (+0.00%)          13          13      +0 (+0.00%)               13    =
           13         +0 (+0.00%)
> bpf_execve_bprm_commit_creds.o  tg_kp_bprm_committing_creds              =
    100                 95           -5 (-5.00%)        163        163     =
  +0 (+0.00%)          14          14      +0 (+0.00%)               14    =
           14         +0 (+0.00%)
> bpf_execve_event.o              event_execve                             =
  12147              12843         +696 (+5.73%)      35096      34723     =
-373 (-1.06%)        2278        2251     -27 (-1.19%)             1110    =
         1115         +5 (+0.45%)
> bpf_execve_event.o              execve_send                              =
     93                 57         -36 (-38.71%)         82         82     =
  +0 (+0.00%)           6           6      +0 (+0.00%)                6    =
            6         +0 (+0.00%)
> bpf_execve_event_v53.o          event_execve                             =
  97457              98430         +973 (+1.00%)     245365     239363    -=
6002 (-2.45%)       15430       15334     -96 (-0.62%)             7994    =
         7929        -65 (-0.81%)
> bpf_execve_event_v53.o          execve_send                              =
     52                 54           +2 (+3.85%)        105        105     =
  +0 (+0.00%)           5           5      +0 (+0.00%)                5    =
            5         +0 (+0.00%)
> bpf_execve_event_v61.o          event_execve                             =
   6094               6059          -35 (-0.57%)      27456      26871     =
-585 (-2.13%)         671         636     -35 (-5.22%)              301    =
          309         +8 (+2.66%)
> bpf_execve_event_v61.o          execve_send                              =
     66                 69           +3 (+4.55%)        105        105     =
  +0 (+0.00%)           5           5      +0 (+0.00%)                5    =
            5         +0 (+0.00%)
> bpf_exit.o                      event_exit                               =
     65                 53         -12 (-18.46%)         94         94     =
  +0 (+0.00%)           8           8      +0 (+0.00%)                8    =
            8         +0 (+0.00%)
> bpf_fork.o                      event_wake_up_new_task                   =
    179                209         +30 (+16.76%)        514        514     =
  +0 (+0.00%)          30          30      +0 (+0.00%)               30    =
           30         +0 (+0.00%)

[...]

