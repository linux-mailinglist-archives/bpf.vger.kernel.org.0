Return-Path: <bpf+bounces-35826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ED193E39B
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 06:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53528B213DD
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 04:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D674A2C;
	Sun, 28 Jul 2024 04:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tcJVKpKQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F801877
	for <bpf@vger.kernel.org>; Sun, 28 Jul 2024 04:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722140841; cv=none; b=XIt7I96VSUAgLaNFJbD/w4uu/JN+zjrpNG0w5Dvs/jmpIcK/A7xNfv7nkSbCmGqq3SzJBl5R5GiFpZ41WcadJ12U56oeX5F8ngAeP96pzwEPXg4lrmYm8wfCLETjMgl/BfysDpIIZJQVW6IEif86iUZ6mZa7pGDKpsai4M3omXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722140841; c=relaxed/simple;
	bh=BOcM8tmyCAAculI+zJ+6c+V2gB7VcqR5BVAR3KEtv6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKKv5diH6bcY1AhmI018PTSsPObRoipR0/c8i5OhXhMRYpumobJN/b67zPX2Ix+EXklVfJG3j2T1rHjP28BRuvlH1s1zvL3XdYnJ4dhXJP3oQw5xwlVGeeMVfz9UD7viscDIzGzQU6imLuIzLxbvv7Tt5SP79f2hxIlqWe4Dido=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tcJVKpKQ; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <44d1a208-684a-4c68-a4a6-41d906e87585@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722140834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XeAy6C8eRQGE7CjcN7IRLLJ5CefJdaKGthvc1ioEWgY=;
	b=tcJVKpKQW4pQuLdJ45hddRbJhmmZzep31UpRK+QLlS2/B58L1tsvaZ9bfQxgu98NMBhCxJ
	oZeIl9B1LTv5HXjFfFZ77nlRjyyusHv4EbxLqW9/IBeieLzUxKplqwrM/CEi+30WxVvEWE
	acejUboE2kEr7X8wIoYTCzY5hcDoneM=
Date: Sat, 27 Jul 2024 21:27:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] selftests/bpf: Filter out _GNU_SOURCE when compiling
 test_cpp
To: Stanislav Fomichev <sdf@fomichev.me>, Jakub Kicinski <kuba@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org
References: <20240725214029.1760809-1-sdf@fomichev.me>
 <CAEf4BzYonHCyFr7ivRDDUtsJY3MEgWRKwVZ=N0sWjpMrn1dR6A@mail.gmail.com>
 <20240726181020.19bca47d@kernel.org> <ZqRqXYljLTSKaFwz@mini-arch>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZqRqXYljLTSKaFwz@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/26/24 8:32 PM, Stanislav Fomichev wrote:
> On 07/26, Jakub Kicinski wrote:
>> On Fri, 26 Jul 2024 17:45:06 -0700 Andrii Nakryiko wrote:
>>> or we could
>>>
>>> #ifndef _GNU_SOURCE
>>> #define _GNU_SOURCE
>>> #endif
>>>
>>> (though we have 61 places with that...) so as to not have to update
>>> every target in Makefile.
>> AFAIU we have -D_GNU_SOURCE= twice _in the command line args_ :(
>> One is from the Makefile which now always adds it to CFLAGS,
>> the other is "built-in" in g++ for some weird reason.
>>
>> FWIW I have added this patch to the netdev "hack queue" so no
>> preference any more where the patch lands :)
> Yeah, it can't be fixed with an ifdef because the conflict happens a bit
> earlier:
>
> $ echo "int main(int argc, char *argv[]){return 0;}" > test.cpp
> $ clang++ -Wall -Werror -D_GNU_SOURCE= test.cpp
> In file included from <built-in>:454:
> <command line>:1:9: error: '_GNU_SOURCE' macro redefined [-Werror,-Wmacro-redefined]
>      1 | #define _GNU_SOURCE
>        |         ^
> <built-in>:445:9: note: previous definition is here
>    445 | #define _GNU_SOURCE 1
>        |         ^

The above _GNU_SOURCE definition is defined by clang itself in the very beginning
of compilation.
See https://github.com/llvm/llvm-project/blob/main/clang/lib/Basic/Targets/OSTargets.h

// Linux target
template <typename Target>
class LLVM_LIBRARY_VISIBILITY LinuxTargetInfo : public OSTargetInfo<Target> {
protected:
   void getOSDefines(const LangOptions &Opts, const llvm::Triple &Triple,
                     MacroBuilder &Builder) const override {
     // Linux defines; list based off of gcc output
     DefineStd(Builder, "unix", Opts);
     DefineStd(Builder, "linux", Opts);
     if (Triple.isAndroid()) {
       Builder.defineMacro("__ANDROID__", "1");
       this->PlatformName = "android";
       this->PlatformMinVersion = Triple.getEnvironmentVersion();
       const unsigned Maj = this->PlatformMinVersion.getMajor();
       if (Maj) {
         Builder.defineMacro("__ANDROID_MIN_SDK_VERSION__", Twine(Maj));
         // This historical but ambiguous name for the minSdkVersion macro. Keep
         // defined for compatibility.
         Builder.defineMacro("__ANDROID_API__", "__ANDROID_MIN_SDK_VERSION__");
       }
     } else {
         Builder.defineMacro("__gnu_linux__");
     }
     if (Opts.POSIXThreads)
       Builder.defineMacro("_REENTRANT");
     if (Opts.CPlusPlus)
       Builder.defineMacro("_GNU_SOURCE");
     if (this->HasFloat128)
       Builder.defineMacro("__FLOAT128__");
   }
...

This caused a conflict with -D_GNU_SOURCE= and hence compilation failure.

> 1 error generated.


