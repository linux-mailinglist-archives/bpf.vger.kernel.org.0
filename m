Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9F56785C1
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 20:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjAWTFE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 14:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjAWTFD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 14:05:03 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69372658F;
        Mon, 23 Jan 2023 11:05:02 -0800 (PST)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pK27m-00070k-O9; Mon, 23 Jan 2023 20:04:59 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pK27m-000ON9-8v; Mon, 23 Jan 2023 20:04:58 +0100
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Use BPF_KFUNC macro at all kfunc
 definitions
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, memxor@gmail.com
References: <20230123171506.71995-1-void@manifault.com>
 <20230123171506.71995-4-void@manifault.com>
 <20230123183305.2mgoxgw4ca3sfk24@macbook-pro-6.dhcp.thefacebook.com>
 <Y87We/92xiv5/+g+@maniforge.lan>
 <20230123185434.ybfhrmbootcnjuoj@macbook-pro-6.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ebff2166-8a70-af62-b859-6b5c6b008b36@iogearbox.net>
Date:   Mon, 23 Jan 2023 20:04:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230123185434.ybfhrmbootcnjuoj@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26790/Mon Jan 23 09:31:32 2023)
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/23/23 7:54 PM, Alexei Starovoitov wrote:
> On Mon, Jan 23, 2023 at 12:48:27PM -0600, David Vernet wrote:
>> On Mon, Jan 23, 2023 at 10:33:05AM -0800, Alexei Starovoitov wrote:
>>> On Mon, Jan 23, 2023 at 11:15:06AM -0600, David Vernet wrote:
>>>> -void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
>>>> +BPF_KFUNC(void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign))
>>>>   {
>>>>   	struct btf_struct_meta *meta = meta__ign;
>>>>   	u64 size = local_type_id__k;
>>>> @@ -1790,7 +1786,7 @@ void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
>>>>   	return p;
>>>>   }
>>>>   
>>>> -void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
>>>> +BPF_KFUNC(void bpf_obj_drop_impl(void *p__alloc, void *meta__ign))
>>>>   {
>>>
>>> The following also works:
>>> -BPF_KFUNC(void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign))
>>> +BPF_KFUNC(
>>> +void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
>>> +)
>>>
>>> and it looks little bit cleaner to me.
>>>
>>> git grep -A1 BPF_KFUNC
>>> can still find all instances of kfuncs.
>>>
>>> wdyt?
>>
>> I'm fine with putting it on its own line if that's your preference.
>> Agreed that it might be a bit cleaner, especially for functions with the
>> return type on its own line, so we'd have e.g.:
>>
>> BPF_KFUNC(
>> struct nf_conn *
>> bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
>> 		  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
> 
> Yeah. Especially for those.
> 
>> ) {
>>
>> // ...
>>
>> }
>>
>> Note the presence of the { on the closing paren. Are you ok with that?
>> Otherwise I think it will look a bit odd:
> 
> Yep. Good idea. Either ){ or ) { look good to me.
> 
>> BPF_KFUNC(
>> struct nf_conn *
>> bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
>> 		  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
>> )
>> {
>>
>> }

Did you look into making this similar to the EXPORT_SYMBOL() infra? If possible
that would look much more natural to developers, e.g. :

struct nf_conn *
bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
  		  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
{
	[...]
}

EXPORT_BPF_KFUNC(bpf_skb_ct_lookup);
