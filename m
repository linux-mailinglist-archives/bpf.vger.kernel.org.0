Return-Path: <bpf+bounces-4766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D246174F1B4
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 16:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64CB0281861
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 14:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E2C19BB7;
	Tue, 11 Jul 2023 14:19:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779FE19BAF
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 14:19:49 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238B51994
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 07:19:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso32392725e9.1
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 07:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689085166; x=1691677166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8+AYxhOC9+QFLEcw26kNzr9G5hqgdDEzPKb+UZOi+g=;
        b=h04+Ct45Yx5uJfpduFKD34QBpkW/G4NLQZe4KtT54CDtHleK1ake11F1rwqWisgC//
         UQCn3lS5/7rNckTT4cm/OupRX2fCzuHEG6xX0hBpdGeoHdVZxTqLZ5c+3/hSEnrwcPg5
         hUUlNsR4+FFcyyMzW52jOzGGf4grcJYYMJrk7JiYpvjdms1g88n4O6LldWt4OcapVLz5
         BJeth4EEUeWIN/RrWxOHCnyxnLQGToOqBpBXfTBbPjqFxE/1MS4G+/VcdATJNoest9lw
         qSAnYiflxZZbtWaBDDEUMXEiha0R6r1jTgENNmyUFqa3RvCyTc0oF7W7T9cq8ogOiihI
         k9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085166; x=1691677166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8+AYxhOC9+QFLEcw26kNzr9G5hqgdDEzPKb+UZOi+g=;
        b=VOKXXqR5AZN+NGvF3YB2WCbePsu3RXM7yoGvQeBj470AOZ8EdDlkRZT1KfaLdUQECg
         nfJW7yjNR6lCFwbbp8Xt3ceSV3DwiC2kNiaqPCVqvYkhzDeYkVBr2YPO0JBlkBeTp75k
         iU2qqzCAjmEOFs1LE5SXwU6faK5HLLX4Fem1y54KIYobCe9C2wajqXgVhY561WGv+Re+
         ZULtPB0EPI/kEgf5MShWUKLYjsTkTYg9DupqEbCcvc9hRrbbmCjZ555Q8+dAzlwdYpjf
         IGHTGA3i4kfYMXa4BjBg7Fp/dInFoVYNcObKe8r4mv4MWv6iauGgmjlAQfIAyTVCzbMR
         nqiQ==
X-Gm-Message-State: ABy/qLar6XSuG6Z/JnRvG5/DwuFGE8iXdfSuTdBDNyftzEF6cy7I9l7+
	j0rFPEoFlq+CeM1kvrcZU8KDNA==
X-Google-Smtp-Source: APBJJlGgPvMCyU1sS9b/7oa8vwMRWreVGkPlrPT/JhwbMIqTfCN7GmuhAjh8z60EtPozGKrQuj6wrg==
X-Received: by 2002:a1c:6a03:0:b0:3fb:a576:3212 with SMTP id f3-20020a1c6a03000000b003fba5763212mr16266211wmc.39.1689085166489;
        Tue, 11 Jul 2023 07:19:26 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:cdfe:66c0:7817:c4f5? ([2a02:8011:e80c:0:cdfe:66c0:7817:c4f5])
        by smtp.gmail.com with ESMTPSA id z22-20020a7bc7d6000000b003fbcdba1a63sm2671791wmk.12.2023.07.11.07.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 07:19:26 -0700 (PDT)
Message-ID: <f7dd8bef-87c0-123b-c14e-d278fbc7dbe3@isovalent.com>
Date: Tue, 11 Jul 2023 15:19:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v4 6/8] bpftool: Extend net dump with tcx progs
Content-Language: en-GB
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc: andrii@kernel.org, martin.lau@linux.dev, razor@blackwall.org,
 sdf@google.com, john.fastabend@gmail.com, kuba@kernel.org, dxu@dxuuu.xyz,
 joe@cilium.io, toke@kernel.org, davem@davemloft.net, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20230710201218.19460-1-daniel@iogearbox.net>
 <20230710201218.19460-7-daniel@iogearbox.net>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230710201218.19460-7-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-07-10 22:12 UTC+0200 ~ Daniel Borkmann <daniel@iogearbox.net>
> Add support to dump fd-based attach types via bpftool. This includes both
> the tc BPF link and attach ops programs. Dumped information contain the
> attach location, function entry name, program ID and link ID when applicable.
> 
> Example with tc BPF link:
> 
>   # ./bpftool net
>   xdp:
> 
>   tc:
>   bond0(4) tcx/ingress cil_from_netdev prog id 784 link id 10
>   bond0(4) tcx/egress cil_to_netdev prog id 804 link id 11
> 
>   flow_dissector:
> 
>   netfilter:
> 
> Example with tc BPF attach ops:
> 
>   # ./bpftool net
>   xdp:
> 
>   tc:
>   bond0(4) tcx/ingress cil_from_netdev prog id 654
>   bond0(4) tcx/egress cil_to_netdev prog id 672
> 
>   flow_dissector:
> 
>   netfilter:
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thank you!

If you respin, would you mind updating the docs please
(Documentation/bpftool-net.rst), I realise it says that "bpftool net"
only dumps for tc and XDP, but that's not true any more since we have
the flow dissector, netfilter programs, and now tcx. The examples are
out-of-date too, but updating them doesn't have to be part of this PR.

> ---
>  tools/bpf/bpftool/net.c | 86 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 82 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
> index 26a49965bf71..22af0a81458c 100644
> --- a/tools/bpf/bpftool/net.c
> +++ b/tools/bpf/bpftool/net.c
> @@ -76,6 +76,11 @@ static const char * const attach_type_strings[] = {
>  	[NET_ATTACH_TYPE_XDP_OFFLOAD]	= "xdpoffload",
>  };
>  
> +static const char * const attach_loc_strings[] = {
> +	[BPF_TCX_INGRESS]		= "tcx/ingress",
> +	[BPF_TCX_EGRESS]		= "tcx/egress",
> +};
> +
>  const size_t net_attach_type_size = ARRAY_SIZE(attach_type_strings);
>  
>  static enum net_attach_type parse_attach_type(const char *str)
> @@ -422,8 +427,80 @@ static int dump_filter_nlmsg(void *cookie, void *msg, struct nlattr **tb)
>  			      filter_info->devname, filter_info->ifindex);
>  }
>  
> -static int show_dev_tc_bpf(int sock, unsigned int nl_pid,
> -			   struct ip_devname_ifindex *dev)
> +static const char *flags_strings(__u32 flags)
> +{
> +	return json_output ? "none" : "";
> +}
> +
> +static int __show_dev_tc_bpf_name(__u32 id, char *name, size_t len)
> +{
> +	struct bpf_prog_info info = {};
> +	__u32 ilen = sizeof(info);
> +	int fd, ret;
> +
> +	fd = bpf_prog_get_fd_by_id(id);
> +	if (fd < 0)
> +		return fd;
> +	ret = bpf_obj_get_info_by_fd(fd, &info, &ilen);
> +	if (ret < 0)
> +		goto out;
> +	ret = -ENOENT;
> +	if (info.name[0]) {
> +		get_prog_full_name(&info, fd, name, len);
> +		ret = 0;
> +	}
> +out:
> +	close(fd);
> +	return ret;
> +}
> +
> +static void __show_dev_tc_bpf(const struct ip_devname_ifindex *dev,
> +			      const enum bpf_attach_type loc)
> +{
> +	__u32 prog_flags[64] = {}, link_flags[64] = {}, i;
> +	__u32 prog_ids[64] = {}, link_ids[64] = {};
> +	LIBBPF_OPTS(bpf_prog_query_opts, optq);
> +	char prog_name[MAX_PROG_FULL_NAME];
> +	int ret;
> +
> +	optq.prog_ids = prog_ids;
> +	optq.prog_attach_flags = prog_flags;
> +	optq.link_ids = link_ids;
> +	optq.link_attach_flags = link_flags;
> +	optq.count = ARRAY_SIZE(prog_ids);
> +
> +	ret = bpf_prog_query_opts(dev->ifindex, loc, &optq);
> +	if (ret)
> +		return;
> +	for (i = 0; i < optq.count; i++) {
> +		NET_START_OBJECT;
> +		NET_DUMP_STR("devname", "%s", dev->devname);
> +		NET_DUMP_UINT("ifindex", "(%u)", dev->ifindex);
> +		NET_DUMP_STR("kind", " %s", attach_loc_strings[loc]);
> +		ret = __show_dev_tc_bpf_name(prog_ids[i], prog_name,
> +					     sizeof(prog_name));
> +		if (!ret)
> +			NET_DUMP_STR("name", " %s", prog_name);
> +		NET_DUMP_UINT("prog_id", " prog id %u", prog_ids[i]);

I was unsure at first about having two words for "prog id", or "link id"
below (we use "prog_id" for netfilter, for example), but I see it leaves
you the opportunity to append the flags, if any, without additional
keywords so... why not.

> +		if (prog_flags[i])
> +			NET_DUMP_STR("prog_flags", "%s", flags_strings(prog_flags[i]));
> +		if (link_ids[i])
> +			NET_DUMP_UINT("link_id", " link id %u",
> +				      link_ids[i]);
> +		if (link_flags[i])
> +			NET_DUMP_STR("link_flags", "%s", flags_strings(link_flags[i]));
> +		NET_END_OBJECT_FINAL;
> +	}
> +}
> +
> +static void show_dev_tc_bpf(struct ip_devname_ifindex *dev)
> +{
> +	__show_dev_tc_bpf(dev, BPF_TCX_INGRESS);
> +	__show_dev_tc_bpf(dev, BPF_TCX_EGRESS);
> +}
> +
> +static int show_dev_tc_bpf_classic(int sock, unsigned int nl_pid,
> +				   struct ip_devname_ifindex *dev)
>  {
>  	struct bpf_filter_t filter_info;
>  	struct bpf_tcinfo_t tcinfo;
> @@ -790,8 +867,9 @@ static int do_show(int argc, char **argv)
>  	if (!ret) {
>  		NET_START_ARRAY("tc", "%s:\n");
>  		for (i = 0; i < dev_array.used_len; i++) {
> -			ret = show_dev_tc_bpf(sock, nl_pid,
> -					      &dev_array.devices[i]);
> +			show_dev_tc_bpf(&dev_array.devices[i]);
> +			ret = show_dev_tc_bpf_classic(sock, nl_pid,
> +						      &dev_array.devices[i]);
>  			if (ret)
>  				break;
>  		}


