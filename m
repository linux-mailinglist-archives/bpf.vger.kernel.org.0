Return-Path: <bpf+bounces-4778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 120F274F612
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 18:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12B7281914
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 16:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DD41DDDF;
	Tue, 11 Jul 2023 16:47:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041D443D;
	Tue, 11 Jul 2023 16:47:27 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BC1270E;
	Tue, 11 Jul 2023 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=cxdP5k1Wf4ucsxHqN/1D2ttZdsn5N5+5P8fLYTup9VE=; b=GWgTwaw6zlUGFD3vYGAdeNqxX9
	uqwIzSuoRghrMOnQCdGIxltuQJX8CcwXfwfY7AjE+OLOzLnOnAkYo8s4g8nSJUNKDH936kQ6+F4K4
	cOeL3k4HQM7e8y0+GuMuTdgN+i6D0n24S6YloxqltqcNyBROz2dCrPowde3H/kPxfSL96VyOdsbVD
	h6+Jm6wY2OkYMwkqARswxmdrPwIdbxrFf/48oUArFM8lTCvdPHn5fhU3Ycpb4UEhvpUg5QJXzQkKb
	/8Wg9PSmK/PH2CqNLBNhfhGo5hivfyNMu1GU1yIxIi4QGqPEigCyxDSnPibrI0/WxhGhqmTrS+kHL
	XjXJ8VzA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qJGVS-0007sR-Kl; Tue, 11 Jul 2023 18:46:30 +0200
Received: from [81.6.34.132] (helo=localhost.localdomain)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qJGVS-00029L-2t; Tue, 11 Jul 2023 18:46:30 +0200
Subject: Re: [PATCH bpf-next v4 6/8] bpftool: Extend net dump with tcx progs
To: Quentin Monnet <quentin@isovalent.com>, ast@kernel.org
Cc: andrii@kernel.org, martin.lau@linux.dev, razor@blackwall.org,
 sdf@google.com, john.fastabend@gmail.com, kuba@kernel.org, dxu@dxuuu.xyz,
 joe@cilium.io, toke@kernel.org, davem@davemloft.net, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20230710201218.19460-1-daniel@iogearbox.net>
 <20230710201218.19460-7-daniel@iogearbox.net>
 <f7dd8bef-87c0-123b-c14e-d278fbc7dbe3@isovalent.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <85c76195-0a77-a2bb-f4d2-d3ce6ee56530@iogearbox.net>
Date: Tue, 11 Jul 2023 18:46:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f7dd8bef-87c0-123b-c14e-d278fbc7dbe3@isovalent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26966/Tue Jul 11 09:28:31 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/11/23 4:19 PM, Quentin Monnet wrote:
> 2023-07-10 22:12 UTC+0200 ~ Daniel Borkmann <daniel@iogearbox.net>
>> Add support to dump fd-based attach types via bpftool. This includes both
>> the tc BPF link and attach ops programs. Dumped information contain the
>> attach location, function entry name, program ID and link ID when applicable.
>>
>> Example with tc BPF link:
>>
>>    # ./bpftool net
>>    xdp:
>>
>>    tc:
>>    bond0(4) tcx/ingress cil_from_netdev prog id 784 link id 10
>>    bond0(4) tcx/egress cil_to_netdev prog id 804 link id 11
>>
>>    flow_dissector:
>>
>>    netfilter:
>>
>> Example with tc BPF attach ops:
>>
>>    # ./bpftool net
>>    xdp:
>>
>>    tc:
>>    bond0(4) tcx/ingress cil_from_netdev prog id 654
>>    bond0(4) tcx/egress cil_to_netdev prog id 672
>>
>>    flow_dissector:
>>
>>    netfilter:
>>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> 
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> 
> Thank you!
> 
> If you respin, would you mind updating the docs please
> (Documentation/bpftool-net.rst), I realise it says that "bpftool net"
> only dumps for tc and XDP, but that's not true any more since we have
> the flow dissector, netfilter programs, and now tcx. The examples are
> out-of-date too, but updating them doesn't have to be part of this PR.

Good point, I updated the docs and help usage to reflect that.

>>   tools/bpf/bpftool/net.c | 86 +++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 82 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
>> index 26a49965bf71..22af0a81458c 100644
>> --- a/tools/bpf/bpftool/net.c
>> +++ b/tools/bpf/bpftool/net.c
>> @@ -76,6 +76,11 @@ static const char * const attach_type_strings[] = {
>>   	[NET_ATTACH_TYPE_XDP_OFFLOAD]	= "xdpoffload",
>>   };
>>   
>> +static const char * const attach_loc_strings[] = {
>> +	[BPF_TCX_INGRESS]		= "tcx/ingress",
>> +	[BPF_TCX_EGRESS]		= "tcx/egress",
>> +};
>> +
>>   const size_t net_attach_type_size = ARRAY_SIZE(attach_type_strings);
>>   
>>   static enum net_attach_type parse_attach_type(const char *str)
>> @@ -422,8 +427,80 @@ static int dump_filter_nlmsg(void *cookie, void *msg, struct nlattr **tb)
>>   			      filter_info->devname, filter_info->ifindex);
>>   }
>>   
>> -static int show_dev_tc_bpf(int sock, unsigned int nl_pid,
>> -			   struct ip_devname_ifindex *dev)
>> +static const char *flags_strings(__u32 flags)
>> +{
>> +	return json_output ? "none" : "";
>> +}
>> +
>> +static int __show_dev_tc_bpf_name(__u32 id, char *name, size_t len)
>> +{
>> +	struct bpf_prog_info info = {};
>> +	__u32 ilen = sizeof(info);
>> +	int fd, ret;
>> +
>> +	fd = bpf_prog_get_fd_by_id(id);
>> +	if (fd < 0)
>> +		return fd;
>> +	ret = bpf_obj_get_info_by_fd(fd, &info, &ilen);
>> +	if (ret < 0)
>> +		goto out;
>> +	ret = -ENOENT;
>> +	if (info.name[0]) {
>> +		get_prog_full_name(&info, fd, name, len);
>> +		ret = 0;
>> +	}
>> +out:
>> +	close(fd);
>> +	return ret;
>> +}
>> +
>> +static void __show_dev_tc_bpf(const struct ip_devname_ifindex *dev,
>> +			      const enum bpf_attach_type loc)
>> +{
>> +	__u32 prog_flags[64] = {}, link_flags[64] = {}, i;
>> +	__u32 prog_ids[64] = {}, link_ids[64] = {};
>> +	LIBBPF_OPTS(bpf_prog_query_opts, optq);
>> +	char prog_name[MAX_PROG_FULL_NAME];
>> +	int ret;
>> +
>> +	optq.prog_ids = prog_ids;
>> +	optq.prog_attach_flags = prog_flags;
>> +	optq.link_ids = link_ids;
>> +	optq.link_attach_flags = link_flags;
>> +	optq.count = ARRAY_SIZE(prog_ids);
>> +
>> +	ret = bpf_prog_query_opts(dev->ifindex, loc, &optq);
>> +	if (ret)
>> +		return;
>> +	for (i = 0; i < optq.count; i++) {
>> +		NET_START_OBJECT;
>> +		NET_DUMP_STR("devname", "%s", dev->devname);
>> +		NET_DUMP_UINT("ifindex", "(%u)", dev->ifindex);
>> +		NET_DUMP_STR("kind", " %s", attach_loc_strings[loc]);
>> +		ret = __show_dev_tc_bpf_name(prog_ids[i], prog_name,
>> +					     sizeof(prog_name));
>> +		if (!ret)
>> +			NET_DUMP_STR("name", " %s", prog_name);
>> +		NET_DUMP_UINT("prog_id", " prog id %u", prog_ids[i]);
> 
> I was unsure at first about having two words for "prog id", or "link id"
> below (we use "prog_id" for netfilter, for example), but I see it leaves
> you the opportunity to append the flags, if any, without additional
> keywords so... why not.

Ok, I'll change it into prog_id, link_id for consistency for the human readable output.

And some like flow dissector just dump 'id'. After sync with Quentin, I tracked this
in [0] to more streamline the net dump output for other types.

   [0] https://github.com/libbpf/bpftool/issues/106

Thanks,
Daniel

