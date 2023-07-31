Return-Path: <bpf+bounces-6425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1580F769260
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 11:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D7628164E
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 09:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C4817FE3;
	Mon, 31 Jul 2023 09:53:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2321917ADF
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 09:53:27 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867B610CC
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 02:52:55 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b703a0453fso63244401fa.3
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 02:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690797172; x=1691401972;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=iS9ynVL/SnopVJ2vw9YOzxEVqWQLoL/quqMJip/rlSE=;
        b=TJGih8nCWL5gxD2BWkapKv6qzLQgYlt7Dn6tUvA7zsBBkj0NosBGxU6y4wTEHIMu9b
         QNhfWKg5PLY3Lopd3sj6iaUhOmghM4XdsG0krJt7pnnvs8nkdNgFXco002qJe6S1WLjL
         4D5feAhqvaQ0OrqYsnoNvfQpn+ks1/c6mkHzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690797172; x=1691401972;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iS9ynVL/SnopVJ2vw9YOzxEVqWQLoL/quqMJip/rlSE=;
        b=IsiKwIlL29LyhIj4Ow40+ES1fb2OGP4Wtal6Cu8adRLknAgrTXOYw6RfliLSpbGTGa
         WU4lSdX+1WKz4iRUKkG4CM+jv8vuOzoN5i5uxCedQxURn8a8s95Qhd1uBkX+XdrexG5L
         lbNXm8EEWlW14mIu6DMlgRRXwXq3tS8ZZn5C9s3Re/Xsd5p4lj2XXRqfTlmwziPg90m/
         h++0CiuteL18S6uLFV0/fWT5ad5iO5gBLQDrlH/0ujSuyGc6tintG1XyKCdygxdQ9r7m
         eYoYSyz9rxFUur4vq7oL4h+h9TiXrKL2uPnl8A0JF1NgGLSBhdg5dZ83VrB8Bsqc45GE
         aWRQ==
X-Gm-Message-State: ABy/qLZaxAgzqCLvVu/NqZvBZ77mT6aiSwwhCtd87jPxL8mK86ODrGhf
	mjeLtqxW7CfiFR0wvIiN17KdHw==
X-Google-Smtp-Source: APBJJlFIqs6ieNOIG6CV6VOvY4r1Ja1rFjHMIrHJIuZjzIq57jXM6bn1exmD7gtibtpDJrxd12r9Rg==
X-Received: by 2002:a2e:8557:0:b0:2b9:4821:22b6 with SMTP id u23-20020a2e8557000000b002b9482122b6mr6184560ljj.10.1690797172186;
        Mon, 31 Jul 2023 02:52:52 -0700 (PDT)
Received: from cloudflare.com (79.184.136.135.ipv4.supernova.orange.pl. [79.184.136.135])
        by smtp.gmail.com with ESMTPSA id q24-20020a17090622d800b0098d2f703408sm5858343eja.118.2023.07.31.02.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:52:51 -0700 (PDT)
References: <cover.1690332693.git.yan@cloudflare.com>
 <9c4896b109a39c3fa088844addaa1737a84bbbb5.1690332693.git.yan@cloudflare.com>
 <791b919c-de82-6dc8-905a-520543f975cd@linux.dev>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Yan Zhai <yan@cloudflare.com>, bpf@vger.kernel.org, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mykola Lysenko
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com, Jordan Griege
 <jgriege@cloudflare.com>, Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v4 bpf 2/2] bpf: selftests: add lwt redirect regression
 test cases
Date: Mon, 31 Jul 2023 11:48:40 +0200
In-reply-to: <791b919c-de82-6dc8-905a-520543f975cd@linux.dev>
Message-ID: <87edkoflvx.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 03:47 PM -07, Martin KaFai Lau wrote:
> On 7/25/23 6:09 PM, Yan Zhai wrote:

[...]

>> diff --git a/tools/testing/selftests/bpf/test_lwt_redirect.sh
>> b/tools/testing/selftests/bpf/test_lwt_redirect.sh
>> new file mode 100755
>> index 000000000000..1b7b78b48174
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/test_lwt_redirect.sh
>
> This has to be written in the test_progs infrastructure in C. Only test_progs is
> run by the BPF CI. Take a look at other tests in prog_tests/. For example,
> tc_redirect.c and xdp_metadata.c which are having setup in netns/link/...etc. It
> currently has helpers to add tc qdisc and filter but not adding route yet which
> could be a useful addition.

Can we help make the BPF CI better so that it also runs other tests in
addition test_progs?

We have bpf selftests written in shell and even Python. These are
sometimes the right tools for the job and make adding tests easier,
IMHO. Network setup from C is verbose and tedious. Not to mention, hard
to read through.

# ./run_kselftest.sh --list
bpf:test_verifier
bpf:test_tag
bpf:test_maps
bpf:test_lru_map
bpf:test_lpm_map
bpf:test_progs
bpf:test_dev_cgroup
bpf:test_sock
bpf:test_sockmap
bpf:get_cgroup_id_user
bpf:test_cgroup_storage
bpf:test_tcpnotify_user
bpf:test_sysctl
bpf:test_progs-no_alu32
bpf:test_kmod.sh
bpf:test_xdp_redirect.sh
bpf:test_xdp_redirect_multi.sh
bpf:test_xdp_meta.sh
bpf:test_xdp_veth.sh
bpf:test_offload.py
bpf:test_sock_addr.sh
bpf:test_tunnel.sh
bpf:test_lwt_seg6local.sh
bpf:test_lirc_mode2.sh
bpf:test_skb_cgroup_id.sh
bpf:test_flow_dissector.sh
bpf:test_xdp_vlan_mode_generic.sh
bpf:test_xdp_vlan_mode_native.sh
bpf:test_lwt_ip_encap.sh
bpf:test_tcp_check_syncookie.sh
bpf:test_tc_tunnel.sh
bpf:test_tc_edt.sh
bpf:test_xdping.sh
bpf:test_bpftool_build.sh
bpf:test_bpftool.sh
bpf:test_bpftool_metadata.sh
bpf:test_doc_build.sh
bpf:test_xsk.sh
bpf:test_xdp_features.sh

