Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9BD66584E
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 10:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbjAKJ5c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 04:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239202AbjAKJ4y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 04:56:54 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD6BB6A;
        Wed, 11 Jan 2023 01:53:53 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l26so10680435wme.5;
        Wed, 11 Jan 2023 01:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dWCPpUTph6937ZIGfAu9HizvNZ6X15aqELdShaCVMXg=;
        b=pC4m8ANv4Fq2qCOwykfIkVZQ1UoKCYTkz5z012kWqlW/9B7KxK9mK9FER2Hnpdgvl8
         ELrN0pIIod39p4S1M84ulr1yzoK0lAQ4k4fznDyXY23U26+q8Mjv2p9lwi7pXrhtF9PN
         BkKSiutK9j3kJQnOosK4TEv3FD6bYQ2DJfaRRNp/l55ILZUYjy/IM1I8F0Xe1Rhux5ha
         SH1hPhUBgfGp9g7ZD9gKZguGj0JJ3uI3KK5uzbCzw5LmAFUrzTdYPGAO7k7832pTFbGM
         dRTJVO0A2J+Pvf9B0E1lgRIh4JZ/RMpDzfAKNBXOjwgqscauCuf05N6/YBhEdIJi8iDJ
         didw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWCPpUTph6937ZIGfAu9HizvNZ6X15aqELdShaCVMXg=;
        b=dnEevLQ78yca5/mXP3bAcI9HB9qQmKx17y+UtlDrTyeiuKCt0d6Kz9jgHiVuQ6jyQT
         NxL/kPUBHNXSrYV7QpVH7XBdMcZZFDCcSpcyQMxETmaJlkKdHK7A+0VbvDPId38fPpc5
         QR6uIkaMSXeD6FOHbwW9W5PDwImK3hZRpdNY9U3h5HgWa7BZVxgjye0QGSY6T6PYUr5e
         ik0WU20aiCWvOI46S/JtDDk+53d6tFhZ89eng8Y2RbY8DQTVaCqAPf5ggMliWEO7x3x8
         mMalraQ/7C3XruN4z3eRpsOPEsCCOrNqub6ivQgmXjEyFqc4mfx9hm8Tb03CrV21l8j4
         7mnA==
X-Gm-Message-State: AFqh2kpd2a4Y4t5D5eQMIP3aHAhLcbug2PtlBBXbNmiHoBO/3tmvwpCd
        G9nBVELtQywXqgl35JnwpxI=
X-Google-Smtp-Source: AMrXdXtOfJxVmLg4APib94EnzbdQbur1wKhLjHcidBqebmJ8k/pjoGlnJhVEJRSYArL7CirsUPMvMA==
X-Received: by 2002:a05:600c:35cc:b0:3d3:3c93:af34 with SMTP id r12-20020a05600c35cc00b003d33c93af34mr62535582wmq.2.1673430832242;
        Wed, 11 Jan 2023 01:53:52 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c314e00b003d9fa355387sm5017535wmo.27.2023.01.11.01.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 01:53:51 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 11 Jan 2023 10:53:48 +0100
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Petr Mladek <pmladek@suse.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH 2/3] bpf: Optimize get_modules_for_addrs()
Message-ID: <Y76HLJvfrkoVQKdh@krava>
References: <20221230112729.351-1-thunder.leizhen@huawei.com>
 <20221230112729.351-3-thunder.leizhen@huawei.com>
 <Y7WoZARt37xGpjXD@alley>
 <Y7dBoII5kZnHGFdL@krava>
 <Y7ftxIiV35Wd75lZ@krava>
 <652e0eea-1ab2-a4fd-151a-e634bcb4e1da@huawei.com>
 <Y7wbNinAXM6O62ZF@krava>
 <78754aee-7c06-cbc3-b68c-d723f09b7f77@huawei.com>
 <1efa9a26-e4d2-756a-ea63-74a2eacd0e2d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1efa9a26-e4d2-756a-ea63-74a2eacd0e2d@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 11, 2023 at 04:41:21PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/1/9 23:11, Leizhen (ThunderTown) wrote:
> > 
> > 
> > On 2023/1/9 21:48, Jiri Olsa wrote:
> >> On Mon, Jan 09, 2023 at 04:51:37PM +0800, Leizhen (ThunderTown) wrote:
> >>>
> >>>
> >>> On 2023/1/6 17:45, Jiri Olsa wrote:
> >>>> On Thu, Jan 05, 2023 at 10:31:12PM +0100, Jiri Olsa wrote:
> >>>>> On Wed, Jan 04, 2023 at 05:25:08PM +0100, Petr Mladek wrote:
> >>>>>> On Fri 2022-12-30 19:27:28, Zhen Lei wrote:
> >>>>>>> Function __module_address() can quickly return the pointer of the module
> >>>>>>> to which an address belongs. We do not need to traverse the symbols of all
> >>>>>>> modules to check whether each address in addrs[] is the start address of
> >>>>>>> the corresponding symbol, because register_fprobe_ips() will do this check
> >>>>>>> later.
> >>>>>
> >>>>> hum, for some reason I can see only replies to this patch and
> >>>>> not the actual patch.. I'll dig it out of the lore I guess
> >>>>>
> >>>>>>>
> >>>>>>> Assuming that there are m modules, each module has n symbols on average,
> >>>>>>> and the number of addresses 'addrs_cnt' is abbreviated as K. Then the time
> >>>>>>> complexity of the original method is O(K * log(K)) + O(m * n * log(K)),
> >>>>>>> and the time complexity of current method is O(K * (log(m) + M)), M <= m.
> >>>>>>> (m * n * log(K)) / (K * m) ==> n / log2(K). Even if n is 10 and K is 128,
> >>>>>>> the ratio is still greater than 1. Therefore, the new method will
> >>>>>>> generally have better performance.
> >>>>>
> >>>>> could you try to benchmark that? I tried something similar but was not
> >>>>> able to get better performance
> >>>>
> >>>> hm looks like I tried the smilar thing (below) like you did,
> >>>
> >>> Yes. I just found out you're working on this improvement, too.
> >>>
> >>>> but wasn't able to get better performace
> >>>
> >>> Your implementation below is already the limit that can be optimized.
> >>> If the performance is not improved, it indicates that this place is
> >>> not the bottleneck.
> >>>
> >>>>
> >>>> I guess your goal is to get rid of the module arg in
> >>>> module_kallsyms_on_each_symbol callback that we use?
> >>>
> >>> It's not a bad thing to keep argument 'mod' for function
> >>> module_kallsyms_on_each_symbol(), but for kallsyms_on_each_symbol(),
> >>> it's completely redundant. Now these two functions often use the
> >>> same hook function. So I carefully analyzed get_modules_for_addrs(),
> >>> which is the only place that involves the use of parameter 'mod'.
> >>> Looks like there's a possibility of eliminating parameter 'mod'.
> >>>
> >>>> I'm ok with the change if the performace is not worse
> >>>
> >>> OK, thanks.
> >>>
> >>>>
> >>>> jirka
> >>>>
> >>>>
> >>>> ---
> >>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >>>> index 5b9008bc597b..3280c22009f1 100644
> >>>> --- a/kernel/trace/bpf_trace.c
> >>>> +++ b/kernel/trace/bpf_trace.c
> >>>> @@ -2692,23 +2692,16 @@ struct module_addr_args {
> >>>>  	int mods_cap;
> >>>>  };
> >>>>  
> >>>> -static int module_callback(void *data, const char *name,
> >>>> -			   struct module *mod, unsigned long addr)
> >>>> +static int add_module(struct module_addr_args *args, struct module *mod)
> >>>>  {
> >>>> -	struct module_addr_args *args = data;
> >>>>  	struct module **mods;
> >>>>  
> >>>> -	/* We iterate all modules symbols and for each we:
> >>>> -	 * - search for it in provided addresses array
> >>>> -	 * - if found we check if we already have the module pointer stored
> >>>> -	 *   (we iterate modules sequentially, so we can check just the last
> >>>> -	 *   module pointer)
> >>>> +	/* We iterate sorted addresses and for each within module we:
> >>>> +	 * - check if we already have the module pointer stored for it
> >>>> +	 *   (we iterate sorted addresses sequentially, so we can check
> >>>> +	 *   just the last module pointer)
> >>>>  	 * - take module reference and store it
> >>>>  	 */
> >>>> -	if (!bsearch(&addr, args->addrs, args->addrs_cnt, sizeof(addr),
> >>>> -		       bpf_kprobe_multi_addrs_cmp))
> >>>> -		return 0;
> >>>> -
> >>>>  	if (args->mods && args->mods[args->mods_cnt - 1] == mod)
> >>>>  		return 0;
> >>>
> >>> There'll be problems Petr mentioned.
> >>>
> >>> https://lkml.org/lkml/2023/1/5/191
> >>
> >> ok, makes sense.. I guess we could just search args->mods in here?
> >> are you going to send new version, or should I update my patch with that?
> > 
> > It's better for you to update! I'm not familiar with the bpf module.
> 
> Hi Jiri:
>   Can you attach patch 1/3 when you send the new patch? There's a little
> dependency. Petr has already replied OK to patch 1/3, see [1].
>   Patch 3/3 is just a cleanup, I'll delay updating it after v6.3-rc1, it
> also has a dependency on another patch [2].

ok, will do

jirka
