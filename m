Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4882403AD
	for <lists+bpf@lfdr.de>; Mon, 10 Aug 2020 10:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgHJI46 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Aug 2020 04:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgHJI46 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Aug 2020 04:56:58 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA573C061756
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 01:56:57 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id g19so8543359ejc.9
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 01:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sQcB3+K8vvfoMx71ktiMUYQlkM6bq+AX0BVDQZ2+P5o=;
        b=Cl+rvJGzFDHhbxCnyQk/vHv5Vmc90EiDLDiWN2FVhbnuId9sArqAnjbRlwGtYp6Cq/
         F28elYjt7aWIqXVUc7jY6iehkANN3m+0AbIUWQQqE3T8SGIMHuAdFD4WOlcB3ptL0x25
         lK3J777ZB9THb5Hkuo7PgHB8fsoxxY6Z2A47cYxZORscu93sCNxT4m0S5rCuCST2T4Ch
         yMr32w2tD14iupubXyiGeH1AtEupuYWSu+php2fGc/kFKOQ8L1LXDYsfXyb8/MPNrajT
         zKkAXo93CN7cLf0B+VM1qTBUcWkijoIUcMWZdqQZlslXJj6cEOG7xBe52zyP7nC7K5ji
         vG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sQcB3+K8vvfoMx71ktiMUYQlkM6bq+AX0BVDQZ2+P5o=;
        b=PvEs9SEChRac4agSEKBxub8XjNJKV9SR+lSql7oXfYzOcKtv83USiOOkekjTP9/Iyy
         Gg+FbGmNwlVS/qq0OE7WskOuXTIusJb646DV9seHDvX51fiCmSaDpvuWtaiA9jDszr3A
         X3MbbpudBDf6+1CbV7p3/VwB2ReujCGPZI0HBf3fbK6PbwSUWeyODh6LfTSxx+WbtamL
         1nXf5n0Q3WPie9VGxaEFHqMSj5ystmyL4ODRnoJpdYJKDD9bOmXuTkJjdaCp2rLfZ36Y
         sfuydtCET6nWUXZfkmeU6/k+HpZXjjzAajXofGAG9QligiikrcGykXQLc+3vyDb9uAYX
         gesA==
X-Gm-Message-State: AOAM532pOo4SJieglbbRNUIDjwQFb2lxdN4Wj2nuG1CeVDgwVv02czun
        VMSD4ITNMuWNFVZBcvE+ITF5Qw==
X-Google-Smtp-Source: ABdhPJwe/7oxD8seb94IGhdhxw8+9ucrBRMf76NWX/DErr1puHLn9g72XOQ5mbNMHwZcStBGGJQ65Q==
X-Received: by 2002:a17:906:46c6:: with SMTP id k6mr19443920ejs.230.1597049816163;
        Mon, 10 Aug 2020 01:56:56 -0700 (PDT)
Received: from [192.168.0.28] ([188.252.226.35])
        by smtp.gmail.com with ESMTPSA id p8sm12711825ejx.53.2020.08.10.01.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 01:56:55 -0700 (PDT)
Subject: Re: eBPF CO-RE cross-compilation for 32-bit ARM platforms
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Jakov Smolic <jakov.smolic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
References: <f1b8e140-bc41-4e56-e73f-db11062dddbd@sartura.hr>
 <CAEf4BzYp2WFq7xZxOs9DwBzXE743nuMLjxTLh5xL36CJqnQmvw@mail.gmail.com>
From:   Jakov Petrina <jakov.petrina@sartura.hr>
Message-ID: <64cd4e85-cec8-b254-67b7-76f78ac0aea1@sartura.hr>
Date:   Mon, 10 Aug 2020 10:56:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYp2WFq7xZxOs9DwBzXE743nuMLjxTLh5xL36CJqnQmvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 07/08/2020 21:46, Andrii Nakryiko wrote:
>> First showstopper for cross-compiling aforementioned example on the ARM
>> 32-bit platform has been with regards to generation of the required
>> `vmlinux.h` kernel header from the BTF information. More specifically,
>> our initial approach to have e.g. a compilation target dependency which
>> would invoke `bpftool` at configure time was not appropriate due to
>> several issues: a) CO-RE requires host kernel to have been compiled in
>> such a way to expose BTF information which may not available, and b) the
>> generated `vmlinux.h` was actually architecture-specific.
> 
> That's not exactly true, about "CO-RE requires host kernel to have
> been compiled...". You can pass any kernel image as a parameter to
> bpftool as an input to generate vmlinux.h for that target
> architecture. The only limitation right now, I think, is that their
> endianness have to match. We'll probably get over this limitation some
> time by end of this year, though.
> 

Ah, I was not aware this was possible, thanks; it will certainly cut 
down on the time it takes to generate headers for other arches.

> So in your case, I'd recommend to generate per-architecture vmlinux.h
> and use the appropriate one when you cross-compile. I don't think we
> ever intended to support single CO-RE BPF binary across architectures,
> given it's not too bad to compile same code one time for each target
> architecture. Compiling once for each kernel version/variant was much
> bigger problem, which is what we tackled.
> 

Agreed, kernel compatibility is a bit more crucial here; we are 
comfortable with handling cross-compilation for other arches.

>>
>> However, there are certainly drawbacks to this approach: a) (relatively)
>> large file size of the generated headers, b) regular maintenance to
>> re-generate the header files for various architectures and kernel
>> versions, and c) incompatible definitions being generated, to name a
>> few. This last point relates to the the fact that our `aarch64`/`arm64`
>> kernel generates the following definition using `bpftool`, which has
>> resulted in compilation failure:
>>
>> ```
>> typedef __Poly8_t poly8x16_t[16];
>> ```
>>
>> AFAICT these are ARM NEON intrinsic definitions which are GCC-specific.
>> We have opted to comment out this line as there was no additional
>> `poly8x16_t` usage in the header file.
> 
> Ok, so for a) why the size of vmlinux.h is a big factor? You use it on
> host machine during compilation only, after that you don't have to
> distribute it anywhere. I just checked the size of vmlinux.h we use to
> write BPF programs for production, it's at 2.5MB. Having even few of
> those (if you need x86 + ARM32 + ARM64 + s390x + whatever) isn't a big
> deal, IMO, you can just check them in into your source control system?
> If the size is a concern, I'd be curious to hear why.
> 

Yup, we currently have these files included with our source and it 
hasn't been that bad. However, it struck us as a not the most elegant 
solution given the fact that these are large pre-generated files which 
require manual intervention to update.

However, given that a running kernel is not necessary to create these 
files perhaps we might develop internal tooling to make this process as 
easy as possible.

> b) Hm.. how often do you intend to re-geneate them? Unless you are
> using some bleeding-edge and volatile features of kernel and/or
> compiled-in drivers, you shouldn't need to re-generate it all that
> often. Maybe once every kernel release, maybe even less frequently. We
> update those vmlinux.h only when there is some new set of features
> (e.g., bpf_iter) added and we need those types, or when we get a new
> major kernel version bump. So far so good. But your constraints might
> differ, so I'd like to learn more.
> 

We are currently looking into bleeding-edge features of the kernel, but 
they mostly concern eBPF itself; I suppose that for us, updating these 
headers should be done when new features are introduced to the kernel. 
When we identify applications of eBPF we will most likely have more 
constraints to keep track of.

> c) I addressed in another reply. BTF dumper in libbpf maintains a list
> of types that are compiler-provided and avoid generating types for
> them, assuming compiler will have them. So far we've handled it simply
> for __builtin_va_list, we can probably do something like that here as
> well?
> 

Great, I think that is an acceptable solution.

>>
>> Given various issues we have encountered so far (among which is a kernel
>> panic/crash on a specific device), additional input and feedback
>> regarding cross-compilation of the eBPF utilities would be greatly
>> appreciated.
>>
> 
> Please report the panic with more details separately. If you are
> referring to cross-compiling libbpf-tools in BCC repo, we can play
> with that, generate a separate vmlinux.<arch>.h. It's a bit hard for
> me to test as I don't have easy access to anything beyond x86-64, so
> some help from other folks would be very appreciated.
> 

Thanks, as mentioned in another reply we have been attempting to 
reproduce this issue in a QEMU ARM environment but so far we haven't 
been successful. We will most likely move over to debugging it directly 
on our target hardware and report it when we have more information.

Regards,
-- 
Jakov Petrina
