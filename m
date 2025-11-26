Return-Path: <bpf+bounces-75603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 848B6C8B738
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 19:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6D5B3472BF
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 18:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EC4286400;
	Wed, 26 Nov 2025 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bugEiiRN"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DBC311959
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764181975; cv=none; b=OSEWTlTTR0uzEKEh2vAoBDLZNSQUxqCVnubLdy/ZDC7OeZQTwzU/rmrIOTpr06+jcjt4r/WeHuz3SXOQzxVeqejlFKPu8f0PzoWIymH+se4PX9K3kTl30bJ3k9WJ41GuxP9D1HD49c5WoC6/ivMzWH7TK/u1uXQMuYIsvouLwfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764181975; c=relaxed/simple;
	bh=AOoe5JtT1OHWwr9WMwKaAoJ7KKM01g+Aduh6RSFzgEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=meRAIytUQzacgTsnU/Q6XixFQoZNHes6PEFc6UAkSE5qSirgevM+8nOJGhBXWId8URyR9vc4il7Iy/gWjDj2eHffOGJKGV/6pf1iTqBObLxdZZMI+tnvd/pPqD3BSSMh4qpTCp6CQmcH5yQdVeFIaeWfBDH68JG7LXnyCY5XJfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bugEiiRN; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7fb4b953-449d-4f72-8bc7-2becae3cc639@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764181960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5kl7ivhO8IEcaYStwnE6ABlTpqXsrzXg6GsRqFQk9Jg=;
	b=bugEiiRNridTMoZfkk4a3ngi8Awv7I4mc9QqFHPdagwYHMg1n4+0q0IM9mQ6QGsofYSD1R
	p+g/aLEoNg/uwmche/65NvyMgWtlJURKOQ3kwgqYxYBrvrX36F7k3nY0o8QGXEdvSzNBqe
	ZiK3HbDVVQ2jF2jxRxUkmXmyu9tt0ok=
Date: Wed, 26 Nov 2025 10:32:30 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 4/4] resolve_btfids: change in-place update
 with raw binary output
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 bpf@vger.kernel.org, dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
References: <20251126012656.3546071-1-ihor.solodrai@linux.dev>
 <20251126012656.3546071-5-ihor.solodrai@linux.dev>
 <CAErzpmvaHxLdooTsHt=YKbz9NDw+LXB8462kRrkzbdp-zJ-=2Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAErzpmvaHxLdooTsHt=YKbz9NDw+LXB8462kRrkzbdp-zJ-=2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/25/25 8:46 PM, Donglin Peng wrote:
> On Wed, Nov 26, 2025 at 9:29 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> [...]
>>  static const char * const resolve_btfids_usage[] = {
>> @@ -823,12 +875,13 @@ int main(int argc, const char **argv)
>>                 .funcs    = RB_ROOT,
>>                 .sets     = RB_ROOT,
>>         };
>> +       char out_path[PATH_MAX];
>>         bool fatal_warnings = false;
>>         struct option btfid_options[] = {
>>                 OPT_INCR('v', "verbose", &verbose,
>>                          "be more verbose (show errors, etc)"),
>>                 OPT_STRING(0, "btf", &obj.btf_path, "BTF data",
>> -                          "BTF data"),
>> +                          "input BTF data"),
>>                 OPT_STRING('b', "btf_base", &obj.base_btf_path, "file",
>>                            "path of file providing base BTF"),
>>                 OPT_BOOLEAN(0, "fatal_warnings", &fatal_warnings,
>> @@ -844,6 +897,9 @@ int main(int argc, const char **argv)
>>
>>         obj.path = argv[0];
>>
>> +       if (load_btf(&obj))
>> +               goto out;
> 
> I think I can add the BTF sorting function here based on your patch.

Correct. Any btf2btf transformations will have to happen before the
symbols resolution.

> 
> Thanks,
> Donglin
>> +
>>         if (elf_collect(&obj))
>>                 goto out;
>>
>> @@ -853,23 +909,37 @@ int main(int argc, const char **argv)
>>          */
>>         if (obj.efile.idlist_shndx == -1 ||
>>             obj.efile.symbols_shndx == -1) {
>> -               pr_debug("Cannot find .BTF_ids or symbols sections, nothing to do\n");
>> -               err = 0;
>> -               goto out;
>> +               pr_debug("Cannot find .BTF_ids or symbols sections, skip symbols resolution\n");
>> +               goto dump_btf;
>>         }
>>
>>         if (symbols_collect(&obj))
>>                 goto out;
>>
>> -       if (load_btf(&obj))
>> -               goto out;
>> -
>>         if (symbols_resolve(&obj))
>>                 goto out;
>>
>>         if (symbols_patch(&obj))
>>                 goto out;
>>
>> +       strcpy(out_path, obj.path);
>> +       strcat(out_path, ".btf_ids");
>> +       if (dump_raw_btf_ids(&obj, out_path))
>> +               goto out;
>> +
>> +dump_btf:
>> +       strcpy(out_path, obj.path);
>> +       strcat(out_path, ".btf");
> 
> Do we need to add .btf files to the .gitignore file?

I don't know. Probably?

I take care to cleanup temporary files in the gen-btf.sh, but it makes
sense to .gitignore them anyways, since those are temporary build
artifacts.

> 
> Thanks,
> Donglin
> 
>> +       if (dump_raw_btf(obj.btf, out_path))
>> +               goto out;
>> +
>> +       if (obj.base_btf) {
>> +               strcpy(out_path, obj.path);
>> +               strcat(out_path, ".distilled_base.btf");
>> +               if (dump_raw_btf(obj.base_btf, out_path))
>> +                       goto out;
>> +       }
>> +
>>         if (!(fatal_warnings && warnings))
>>                 err = 0;
>>  out:
>> --
>> 2.52.0
>>


