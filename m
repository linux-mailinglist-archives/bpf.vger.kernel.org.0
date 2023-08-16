Return-Path: <bpf+bounces-7905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 175AA77E4BE
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 17:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488F91C210BA
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 15:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356A7156D7;
	Wed, 16 Aug 2023 15:12:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F15210957
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 15:12:00 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430B210EC
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 08:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=NgGgqbhnxdf83AtfgnFuGZQeI4sHxJDx86AwLvSu2s0=; b=GmAAC/GvwnZ1WnfWQmguF/fOzL
	CeAjo2WMhAgbayTjVxgBYXPblIlNhziVbnkJQmP1VuCavWpCZmrYIP/iwySq5nOBqQmUeTU4IapV4
	vEGw78IjgJ/dWm1VqQDvafAEtgqs/f/loMyFjmgG1aX0CvSYqjCryvU2IrfimIUsdMgS+AHSzqi5M
	pErTYzAHLGz5OU1JmhIJREVZKIyZfGWVQfOvMNwXHGX2nyCJC4u22poandDAgQz26id6XUOfiVpQ3
	aWZNjMZjMs8J8+qEmzHbV9lEOy+4R/MpGSow4kBzRbMFHe/M1gdxfEfIPUn8SEb41WUi8SZkLK3ih
	Rrn95TyA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qWIBe-000OSn-Fy; Wed, 16 Aug 2023 17:11:54 +0200
Received: from [85.1.206.226] (helo=pc-102.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qWIBd-000NWj-QN; Wed, 16 Aug 2023 17:11:53 +0200
Subject: Re: [PATCH bpf-next 1/2] bpftool: Implement link show support for tcx
To: Yafang Shao <laoar.shao@gmail.com>
Cc: martin.lau@linux.dev, bpf@vger.kernel.org,
 Quentin Monnet <quentin@isovalent.com>
References: <20230816095651.10014-1-daniel@iogearbox.net>
 <CALOAHbDtmTPV6enF1M0RnZr4pPyWkr1bZ7afcFchfNYRGVKu7w@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d25d1dc0-d4fc-eb0c-e9cf-ee3d4783e07a@iogearbox.net>
Date: Wed, 16 Aug 2023 17:11:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALOAHbDtmTPV6enF1M0RnZr4pPyWkr1bZ7afcFchfNYRGVKu7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27002/Wed Aug 16 09:38:26 2023)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/16/23 4:23 PM, Yafang Shao wrote:
> On Wed, Aug 16, 2023 at 5:56 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> Add support to dump tcx link information to bpftool. This adds a
>> common helper show_link_ifindex_{plain,json}() which can be reused
>> also for other link types. The plain text and json device output is
>> the same format as in bpftool net dump.
>>
>> Below shows an example link dump output along with a cgroup link
>> for comparison:
>>
>>    # bpftool link
>>    [...]
>>    10: cgroup  prog 1977
>>          cgroup_id 1  attach_type cgroup_inet6_post_bind
>>    [...]
>>    13: tcx  prog 2053
>>          ifindex enp5s0(3)  attach_type tcx_ingress
>>    14: tcx  prog 2080
>>          ifindex enp5s0(3)  attach_type tcx_egress
>>    [...]
>>
>> Equivalent json output:
>>
>>    # bpftool link --json
>>    [...]
>>    {
>>      "id": 10,
>>      "type": "cgroup",
>>      "prog_id": 1977,
>>      "cgroup_id": 1,
>>      "attach_type": "cgroup_inet6_post_bind"
>>    },
>>    [...]
>>    {
>>      "id": 13,
>>      "type": "tcx",
>>      "prog_id": 2053,
>>      "devname": "enp5s0",
>>      "ifindex": 3,
>>      "attach_type": "tcx_ingress"
>>    },
>>    {
>>      "id": 14,
>>      "type": "tcx",
>>      "prog_id": 2080,
>>      "devname": "enp5s0",
>>      "ifindex": 3,
>>      "attach_type": "tcx_egress"
>>    }
>>    [...]
>>
>> Suggested-by: Yafang Shao <laoar.shao@gmail.com>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> 
> Thanks for your work. This patch looks good to me.
> A minor nit below.
> 
>> ---
>>   tools/bpf/bpftool/link.c | 37 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
>> index 65a168df63bc..a3774594f154 100644
>> --- a/tools/bpf/bpftool/link.c
>> +++ b/tools/bpf/bpftool/link.c
>> @@ -150,6 +150,18 @@ static void show_link_attach_type_json(__u32 attach_type, json_writer_t *wtr)
>>                  jsonw_uint_field(wtr, "attach_type", attach_type);
>>   }
>>
>> +static void show_link_ifindex_json(__u32 ifindex, json_writer_t *wtr)
>> +{
>> +       char devname[IF_NAMESIZE] = "(unknown)";
>> +
>> +       if (ifindex)
>> +               if_indextoname(ifindex, devname);
>> +       else
>> +               snprintf(devname, sizeof(devname), "(detached)");
>> +       jsonw_string_field(wtr, "devname", devname);
>> +       jsonw_uint_field(wtr, "ifindex", ifindex);
>> +}
>> +
>>   static bool is_iter_map_target(const char *target_name)
>>   {
>>          return strcmp(target_name, "bpf_map_elem") == 0 ||
>> @@ -433,6 +445,10 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
>>          case BPF_LINK_TYPE_NETFILTER:
>>                  netfilter_dump_json(info, json_wtr);
>>                  break;
>> +       case BPF_LINK_TYPE_TCX:
>> +               show_link_ifindex_json(info->tcx.ifindex, json_wtr);
>> +               show_link_attach_type_json(info->tcx.attach_type, json_wtr);
>> +               break;
>>          case BPF_LINK_TYPE_STRUCT_OPS:
>>                  jsonw_uint_field(json_wtr, "map_id",
>>                                   info->struct_ops.map_id);
>> @@ -509,6 +525,22 @@ static void show_link_attach_type_plain(__u32 attach_type)
>>                  printf("attach_type %u  ", attach_type);
>>   }
>>
>> +static void show_link_ifindex_plain(__u32 ifindex)
>> +{
>> +       char devname[IF_NAMESIZE * 2] = "(unknown)";
>> +       char tmpname[IF_NAMESIZE];
>> +       char *ret = NULL;
>> +
>> +       if (ifindex)
>> +               ret = if_indextoname(ifindex, tmpname);
>> +       else
>> +               snprintf(devname, sizeof(devname), "(detached)");
>> +       if (ret)
>> +               snprintf(devname, sizeof(devname), "%s(%d)",
>> +                        tmpname, ifindex);
>> +       printf("ifindex %s  ", devname);
>> +}
> 
> This function looks a little strange to me. What about the change below?
> 
> static void show_link_ifindex_plain(__u32 ifindex)
> {
>          char devname[IF_NAMESIZE] = "(unknown)";
> 
>          if (ifindex) {
>                  if_indextoname(ifindex, devname);
>                  printf("ifindex %s(%d)  ", devname, ifindex);
>          } else {
>                  printf("ifindex (detached)  ");
>          }
> }

Arguably, it's a corner case (and should never happen), but for the case
where the if_indextoname call fails, I only intended to print `ifindex (unknown)`
for the plain mode hence the check for if_indextoname success so that this
looks similar as `ifindex (detached)` situation.

Thanks,
Daniel

