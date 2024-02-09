Return-Path: <bpf+bounces-21574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C4F84EED4
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 03:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452101F237BB
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 02:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1FD15CB;
	Fri,  9 Feb 2024 02:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/NNPHYt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C121215AF;
	Fri,  9 Feb 2024 02:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707445653; cv=none; b=kQ2Uz7YaBsJ+LQivzTjvPQ4QS/X8McMcG9tYkaNE0o7SlblPw4bmi64iwb3mhJRuux51UPjqlPKflG2sDySaV/P+he0VCxccnOKgS/ssdwHahc+MdLTfbzhpSEMXI1SC7jS7bw5OWAJNuUbGgelfEZP2eZ88gOml+18lzGVFjgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707445653; c=relaxed/simple;
	bh=ns/Mvlqwop9xUQ+s6HUrxZXwL1LrVIE2gNKocZqIGZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5r7kZ1QzvGBTv6CZVLPI75kDvcytXrqOEVLEZMH5yENZidOOv+OCTflBz3l6M0SZaZshIHAePeRmZnh395xD1LncYu/ctsOU7xK+iqUZtkO382Tsb0SZ308pDzTEXWGwiKPVlptMWFXCPzEBlZD2d8bXekWyAzwSNYcRB4UscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/NNPHYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369AEC433F1;
	Fri,  9 Feb 2024 02:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707445653;
	bh=ns/Mvlqwop9xUQ+s6HUrxZXwL1LrVIE2gNKocZqIGZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q/NNPHYta14WToW10B1jDtf5GB71d020cOck6SAiVs0HxnVHub+JpbRUc15VBhWSV
	 V0Xkl6/f3+xE2W2K3syL2s98cvi5JicoIUoXeFs0Bng4raT4MJ16l3wEXxczxJ4jet
	 x+NV/1T3ib99o8aaqTxIKuGLUYy4W9T2oB510D0Oh7ayljAjCsslKEs8v5HQqxA0Ho
	 cecWZQfXc40jjyqKPoO/i2Y9XuCaSzS2Zw8ml2zdA2fxO8bEXAvqsbNNgaWS1649nh
	 Xny8qjuqDL4LLnpiavfCXKgj5mduYbXU/UDe4HT50WJboYrVh7dvSG1CLXt7E9vPBP
	 9Jxs8eCX1K3Lg==
Date: Thu, 8 Feb 2024 18:27:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org
 (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next v2] net/sched: actions report errors with
 extack
Message-ID: <20240208182731.682985dd@kernel.org>
In-Reply-To: <20240205185537.216873-1-stephen@networkplumber.org>
References: <20240205185537.216873-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Feb 2024 10:52:40 -0800 Stephen Hemminger wrote:
> -static int tcf_bpf_init_from_ops(struct nlattr **tb, struct tcf_bpf_cfg *cfg)
> +static int tcf_bpf_init_from_ops(struct nlattr **tb, struct tcf_bpf_cfg *cfg,
> +				 struct netlink_ext_ack *extack)
>  {
>  	struct sock_filter *bpf_ops;
>  	struct sock_fprog_kern fprog_tmp;
> @@ -193,12 +194,17 @@ static int tcf_bpf_init_from_ops(struct nlattr **tb, struct tcf_bpf_cfg *cfg)
>  	int ret;
>  
>  	bpf_num_ops = nla_get_u16(tb[TCA_ACT_BPF_OPS_LEN]);
> -	if (bpf_num_ops	> BPF_MAXINSNS || bpf_num_ops == 0)
> +	if (bpf_num_ops	> BPF_MAXINSNS || bpf_num_ops == 0) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "Invalid number of BPF instructions %u", bpf_num_ops);

out of range seems better than invalid.
In fact it should be added to the policy.

>  		return -EINVAL;
> +	}
>  
>  	bpf_size = bpf_num_ops * sizeof(*bpf_ops);
> -	if (bpf_size != nla_len(tb[TCA_ACT_BPF_OPS]))
> +	if (bpf_size != nla_len(tb[TCA_ACT_BPF_OPS])) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack, "BPF instruction size %u", bpf_size);

Doesn't sound like an error.
Something about number of instructions not matching the program size
would be better

>  		return -EINVAL;
> +	}
>  
>  	bpf_ops = kmemdup(nla_data(tb[TCA_ACT_BPF_OPS]), bpf_size, GFP_KERNEL);
>  	if (bpf_ops == NULL)
> @@ -221,7 +227,8 @@ static int tcf_bpf_init_from_ops(struct nlattr **tb, struct tcf_bpf_cfg *cfg)
>  	return 0;
>  }
>  
> -static int tcf_bpf_init_from_efd(struct nlattr **tb, struct tcf_bpf_cfg *cfg)
> +static int tcf_bpf_init_from_efd(struct nlattr **tb, struct tcf_bpf_cfg *cfg,
> +				 struct netlink_ext_ack *extack)
>  {
>  	struct bpf_prog *fp;
>  	char *name = NULL;
> @@ -230,8 +237,10 @@ static int tcf_bpf_init_from_efd(struct nlattr **tb, struct tcf_bpf_cfg *cfg)
>  	bpf_fd = nla_get_u32(tb[TCA_ACT_BPF_FD]);
>  
>  	fp = bpf_prog_get_type(bpf_fd, BPF_PROG_TYPE_SCHED_ACT);
> -	if (IS_ERR(fp))
> +	if (IS_ERR(fp)) {
> +		NL_SET_ERR_MSG_MOD(extack, "BPF program type mismatch");
>  		return PTR_ERR(fp);
> +	}
>  
>  	if (tb[TCA_ACT_BPF_NAME]) {
>  		name = nla_memdup(tb[TCA_ACT_BPF_NAME], GFP_KERNEL);
> @@ -292,16 +301,20 @@ static int tcf_bpf_init(struct net *net, struct nlattr *nla,
>  	int ret, res = 0;
>  	u32 index;
>  
> -	if (!nla)
> +	if (!nla) {
> +		NL_SET_ERR_MSG_MOD(extack, "Bpf requires attributes to be passed");

You use "BPF" (capitals) elsewhere. Also not sure the "BPF" prefix is
actually needed, given the _MOD() will prefix this with cls_bpf already.

>  		return -EINVAL;
> +	}
>  
>  	ret = nla_parse_nested_deprecated(tb, TCA_ACT_BPF_MAX, nla,
>  					  act_bpf_policy, NULL);
>  	if (ret < 0)
>  		return ret;
>  
> -	if (!tb[TCA_ACT_BPF_PARMS])
> +	if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_ACT_BPF_PARMS)) {
> +		NL_SET_ERR_MSG(extack, "Missing required attribute");

Please fix the userspace to support missing attr parsing instead.

>  		return -EINVAL;
> +	}
>  
>  	parm = nla_data(tb[TCA_ACT_BPF_PARMS]);
>  	index = parm->index;
> @@ -336,14 +349,15 @@ static int tcf_bpf_init(struct net *net, struct nlattr *nla,
>  	is_ebpf = tb[TCA_ACT_BPF_FD];
>  
>  	if (is_bpf == is_ebpf) {
> +		NL_SET_ERR_MSG_MOD(extack, "Can not specify both BPF fd and ops");

bytecode would be better than ops

>  		ret = -EINVAL;
>  		goto put_chain;
>  	}
>  
>  	memset(&cfg, 0, sizeof(cfg));
>  
> -	ret = is_bpf ? tcf_bpf_init_from_ops(tb, &cfg) :
> -		       tcf_bpf_init_from_efd(tb, &cfg);
> +	ret = is_bpf ? tcf_bpf_init_from_ops(tb, &cfg, extack) :
> +		       tcf_bpf_init_from_efd(tb, &cfg, extack);
>  	if (ret < 0)
>  		goto put_chain;

