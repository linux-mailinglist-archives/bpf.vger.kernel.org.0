Return-Path: <bpf+bounces-3520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9DC73F093
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 03:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59601C209E6
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 01:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3094A40;
	Tue, 27 Jun 2023 01:38:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69A6A23
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 01:38:22 +0000 (UTC)
Received: from out-59.mta1.migadu.com (out-59.mta1.migadu.com [IPv6:2001:41d0:203:375::3b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F24F1700
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 18:38:17 -0700 (PDT)
Message-ID: <211cd152-b018-a803-cd3c-3861eec60eab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1687829895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YgLox7nEBIdunGeXkFfYE9KiRB1P2zlURd3q8WVGjFI=;
	b=OgYibE6+U8GRPzqAsStLZ6gSii4j1JVQc01zTzU5h+/GjKhA6R+G3AQUj81ojDogN4hYwd
	sUU2d9XIvIwzDBYqI4vdKz/OnSI0Q5fRgv106imicEUKd5ap/vACFkiRLUKPe33vwRKJji
	e4HQ6sO69wSbd9xwn8K3ZkgX4dyFrWo=
Date: Tue, 27 Jun 2023 09:37:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] libbpf: kprobe.multi: Filter with
 available_filter_functions_addrs
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: olsajiri@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, bpf@vger.kernel.org, liuyun01@kylinos.cn
References: <20230625011326.1729020-1-liu.yun@linux.dev>
 <CAEf4BzaaBtGTZa4V7QzxUxeKq6D2w+PSXih0sBL4K10UHR3ycw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jackie Liu <liu.yun@linux.dev>
In-Reply-To: <CAEf4BzaaBtGTZa4V7QzxUxeKq6D2w+PSXih0sBL4K10UHR3ycw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/6/27 07:46, Andrii Nakryiko 写道:
> On Sat, Jun 24, 2023 at 6:14 PM Jackie Liu <liu.yun@linux.dev> wrote:
>>
>> From: Jackie Liu <liuyun01@kylinos.cn>
>>
>> When using regular expression matching with "kprobe multi", it scans all
>> the functions under "/proc/kallsyms" that can be matched. However, not all
>> of them can be traced by kprobe.multi. If any one of the functions fails
>> to be traced, it will result in the failure of all functions. The best
>> approach is to filter out the functions that cannot be traced to ensure
>> proper tracking of the functions.
>>
>> Use available_filter_functions_addrs check first, if failed, fallback to
>> kallsyms.
>>
> 
> This is good, but it also doesn't address the original problem. On
> older kernels that don't have available_filter_functions_addrs, we'll
> still be trying to attach to non-attachable kprobes?
> 
> So I think we'll still need to add available_filter_functions-based
> filtering on top of kallsyms. I guess we'll have to collect all
> symbols+addr from kallsyms, sort them, then go over
> available_filter_functions and do binary search. If element is not
> found, we'll mark it for removal. Then last pass to filter out marked
> entries to keep only addrs to be passed to kernel?

The first patch I submitted was to re-search available_filter_functions
in the case of kallsyms matching. The link is at:

https://lore.kernel.org/all/20230523132547.94384-1-liu.yun@linux.dev/,

but it is very slow and takes about 5s to start. If necessary, I can
continue to add it to the V3 patch. Maybe you have other better
algorithms?

-- 
Jackie Liu

> 
> 
>> Here is the test eBPF program [1].
>> [1] https://github.com/JackieLiu1/ketones/tree/master/src/funccount
>>
>> Suggested-by: Jiri Olsa <jolsa@kernel.org>
>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>> ---
>>   tools/lib/bpf/libbpf.c | 81 ++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 75 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index a27f6e9ccce7..fca5d2e412c5 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -10107,6 +10107,12 @@ static const char *tracefs_uprobe_events(void)
>>          return use_debugfs() ? DEBUGFS"/uprobe_events" : TRACEFS"/uprobe_events";
>>   }
>>
>> +static const char *tracefs_available_filter_functions_addrs(void)
>> +{
>> +       return use_debugfs() ? DEBUGFS"/available_filter_functions_addrs" :
>> +                              TRACEFS"/available_filter_functions_addrs";
>> +}
>> +
>>   static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
>>                                           const char *kfunc_name, size_t offset)
>>   {
>> @@ -10422,9 +10428,8 @@ struct kprobe_multi_resolve {
>>          size_t cnt;
>>   };
>>
>> -static int
>> -resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
>> -                       const char *sym_name, void *ctx)
>> +static int ftrace_resolve_kprobe_multi_cb(unsigned long long sym_addr,
>> +                                         const char *sym_name, void *ctx)
>>   {
>>          struct kprobe_multi_resolve *res = ctx;
>>          int err;
>> @@ -10441,6 +10446,63 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
>>          return 0;
>>   }
>>
>> +static int
>> +kallsyms_resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
>> +                                const char *sym_name, void *ctx)
>> +{
>> +       return ftrace_resolve_kprobe_multi_cb(sym_addr, sym_name, ctx);
>> +}
>> +
>> +typedef int (*available_kprobe_cb_t)(unsigned long long sym_addr,
>> +                                    const char *sym_name, void *ctx);
>> +
>> +static int
>> +libbpf_available_kprobes_parse(available_kprobe_cb_t cb, void *ctx)
>> +{
>> +       unsigned long long sym_addr;
>> +       char sym_name[256];
>> +       FILE *f;
>> +       int ret, err = 0;
>> +       const char *available_path = tracefs_available_filter_functions_addrs();
>> +
>> +       f = fopen(available_path, "r");
>> +       if (!f) {
>> +               err = -errno;
>> +               pr_warn("failed to open %s, fallback to /proc/kallsyms.\n",
>> +                       available_path);
> 
> if this is expected to happen, we shouldn't pr_warn() and pollute log output
> 
>> +               return err;
>> +       }
>> +
>> +       while (true) {
>> +               ret = fscanf(f, "%llx %255s%*[^\n]\n", &sym_addr, sym_name);
>> +               if (ret == EOF && feof(f))
>> +                       break;
>> +               if (ret != 2) {
>> +                       pr_warn("failed to read available kprobe entry: %d\n",
>> +                               ret);
>> +                       err = -EINVAL;
>> +                       break;
>> +               }
>> +
>> +               err = cb(sym_addr, sym_name, ctx);
>> +               if (err)
>> +                       break;
>> +       }
>> +
>> +       fclose(f);
>> +       return err;
>> +}
>> +
>> +static void kprobe_multi_resolve_reinit(struct kprobe_multi_resolve *res)
>> +{
>> +       free(res->addrs);
>> +
>> +       /* reset to zero, when fallback */
>> +       res->cap = 0;
>> +       res->cnt = 0;
>> +       res->addrs = NULL;
>> +}
>> +
>>   struct bpf_link *
>>   bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>>                                        const char *pattern,
>> @@ -10477,9 +10539,16 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>>                  return libbpf_err_ptr(-EINVAL);
>>
>>          if (pattern) {
>> -               err = libbpf_kallsyms_parse(resolve_kprobe_multi_cb, &res);
>> -               if (err)
>> -                       goto error;
>> +               err = libbpf_available_kprobes_parse(ftrace_resolve_kprobe_multi_cb,
>> +                                                    &res);
>> +               if (err) {
>> +                       /* fallback to kallsyms */
>> +                       kprobe_multi_resolve_reinit(&res);
> 
> instead of try, fail, try something else approach, can we check that
> tracefs_available_filter_functions_addrs() exists and is readable, and
> if yes -- commit to it. If something fails -- to bad. If it doesn't
> exist, fallback to kallsyms. And we won't need ugly
> kprobe_multi_resolve_reinit() hack.

Sounds good.

> 
>> +                       err = libbpf_kallsyms_parse(kallsyms_resolve_kprobe_multi_cb,
>> +                                                   &res);
>> +                       if (err)
>> +                               goto error;
>> +               }
>>                  if (!res.cnt) {
>>                          err = -ENOENT;
>>                          goto error;
>> --
>> 2.25.1
>>
>>

