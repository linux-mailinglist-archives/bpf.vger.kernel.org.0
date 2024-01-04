Return-Path: <bpf+bounces-19070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FA0824A50
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 22:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A021F25528
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 21:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C542C6B6;
	Thu,  4 Jan 2024 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4X7V4v9X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418742C6B2
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7818487b1d3so57932285a.2
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 13:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704403809; x=1705008609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mOzrK40wE2i86/1eoThEmcjck6rrrkGEQCO3495UBJg=;
        b=4X7V4v9XYwOdZeFfYanur4C4xqOB53IsiSTiamVqTSSIm1eD06zVmF9j8rumCw4/75
         uGfr7LN7l3+vBRRTg9cjbj24vxfPCJZB7gfsrESPfxOEsotO3TLFWbeEpyUwaCieclib
         +akm7EHN3COoEVDrBoi/OLQNvMg+WuEvvodl2pIVid3xnnTJYIUOL7GbFZnk1nDYuofJ
         kWhwBDkmnhh9IrTVvhpYM1E7iaMov0gKm8iyw0DNbWsF13evwMYO4+QID6vh+iKLhST3
         ZVge1fazaL5eKVoAl6upZ3q3XONu3ZP49dYqcmT2oOUp/lxt1kyLm2rYurRiEEaapHn4
         Xo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704403809; x=1705008609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOzrK40wE2i86/1eoThEmcjck6rrrkGEQCO3495UBJg=;
        b=Xo70VLw/SUpwTzZcvXwQOu7JCAMcLTgH4p/TxDNMe2lLGSwG46++NfptLXt+c/xKsK
         /vTOvSIm53icT6w1im64rJRiVF5RGVr8PmoMV73RT776ycY9tIOgcCegl3wZrHhfX0mI
         AGvauHfZ4rPV8AqhlMuN3kFx5o5shSt5+UxrhqTyGOvXi+5w6ri427CoICPfytQXBP76
         GhzxJvuSGeUsptAASXX9F1QnTZdN81AnmF45pXJvTsBnUnMoqahWXfkoQXv3RoTxrVbH
         qmKqvLB3tgbb0xfxQPVuLB0bft63Z9afqIlfMF336qLbVW76+Hsmq0SredaZRrF+yY5Z
         WIpQ==
X-Gm-Message-State: AOJu0YwMJdwHHboPHgQD290xy8IKpcInfz9/LDMVrUx4DkmB6YxhnIWr
	HxwN17Tm/kzBaJq8o5P5SOtBxLKFXgcC
X-Google-Smtp-Source: AGHT+IEmJQXP3/MIeiFTUp/ueNxqjWNjqkvZsJG501M8Pp0+mOihcuWY1SjInPiD8GbwjhMSsxdy+g==
X-Received: by 2002:a05:620a:4895:b0:781:5db7:e1d3 with SMTP id ea21-20020a05620a489500b007815db7e1d3mr1394394qkb.108.1704403809002;
        Thu, 04 Jan 2024 13:30:09 -0800 (PST)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id y20-20020a37e314000000b0077fb4ae1a71sm96785qki.93.2024.01.04.13.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 13:30:08 -0800 (PST)
Message-ID: <e5e52e0a-7494-47bb-8a6a-9819b0c93bd8@google.com>
Date: Thu, 4 Jan 2024 16:30:06 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add inline assembly
 helpers to access array elements
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, Eddy Z <eddyz87@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 mattbobrowski@google.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240103185403.610641-1-brho@google.com>
 <20240103185403.610641-3-brho@google.com> <ZZa1668ft4Npd1DA@krava>
 <f3dd9d80-3fab-4676-b589-1d4667431287@linux.dev>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <f3dd9d80-3fab-4676-b589-1d4667431287@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/4/24 12:31, Yonghong Song wrote:
[snip]

>>> +/*
>>> + * Access an array element within a bound, such that the verifier 
>>> knows the
>>> + * access is safe.
>>> + *
>>> + * This macro asm is the equivalent of:
>>> + *
>>> + *    if (!arr)
>>> + *        return NULL;
>>> + *    if (idx >= arr_sz)
>>> + *        return NULL;
>>> + *    return &arr[idx];
>>> + *
>>> + * The index (___idx below) needs to be a u64, at least for certain 
>>> versions of
>>> + * the BPF ISA, since there aren't u32 conditional jumps.
>>> + */
>>> +#define bpf_array_elem(arr, arr_sz, idx) ({                \
>>> +    typeof(&(arr)[0]) ___arr = arr;                    \
>>> +    __u64 ___idx = idx;                        \
>>> +    if (___arr) {                            \
>>> +        asm volatile("if %[__idx] >= %[__bound] goto 1f;    \
>>> +                  %[__idx] *= %[__size];        \
>>> +                  %[__arr] += %[__idx];        \
>>> +                  goto 2f;                \
>>> +                  1:;                \
>>> +                  %[__arr] = 0;            \
>>> +                  2:                \
>>> +                  "                        \
>>> +                 : [__arr]"+r"(___arr), [__idx]"+r"(___idx)    \
>>> +                 : [__bound]"r"((arr_sz)),                \
>>> +                   [__size]"i"(sizeof(typeof((arr)[0])))    \
>>> +                 : "cc");                    \
>>> +    }                                \
>>> +    ___arr;                                \
>>> +})
> 
> The LLVM bpf backend has made some improvement to handle the case like
>    r1 = ...
>    r2 = r1 + 1
>    if (r2 < num) ...
>    using r1
> by preventing generating the above code pattern.
> 
> The implementation is a pattern matching style so surely it won't be
> able to cover all cases.
> 
> Do you have specific examples which has verification failure due to
> false array out of bound access?

Not in a small example.  =(

This bug has an example, but it was part of a larger program:
https://github.com/google/ghost-userspace/issues/31

The rough progression was:
- sometimes the compiler optimizes out the checks.  So we added a macro 
to make the compiler not know the value of the variable anymore.
- then, the compiler would occasionally do the check on a copy of the 
register, so we did the comparison and index operation all in assembly.


I tried using bpf_cmp_likely() in my actual program (not just a one-off 
test), and still had a verifier issue.  It's a large and convoluted 
program, so it might be hard to get a small reproducer.  But it a 
different compiler issue than the one you mentioned.

Specifically, I swapped out my array-access-macro for this one, using 
bpf_cmp_likely():

#define bpf_array_elem(arr, arr_sz, idx) ({ \
         typeof(&(arr)[0]) ___arr = arr;        \
         typeof(&(arr)[0]) ___ret = 0;          \
         u64 ___idx = idx;                      \
         if (___arr && bpf_cmp_likely(___idx, <, arr_sz))   \
                 ___ret = &___arr[___idx];\
         ___ret;                          \
})

which should be the same logic as before:

  *      if (!arr)
  *              return NULL;
  *      if (idx >= arr_sz)
  *              return NULL;
  *      return &arr[idx];

The issue I run into is different than the one you had.  The compiler 
did the bounds check, but then for some reason recreated the index.  The 
index is coming from another map.

Arguably, the verifier is doing its job - that value could have changed. 
  I just don't want the compiler to do the reread or any other 
shenanigans in between the bounds check and the usage.

The guts of the error:
- r0 is the map (L127)
- r1 is the index, read from another map (L128)
- r1 gets verified to be less than 0x200 (L129)
- some other stuff happens
- r1 gets read again, and is no longer bound (L132)
- r1 gets scaled up by 896.
   (896*0x200 = 0x70000, would be the real bound, but r1 lost the 0x200 
bound)
- r0 indexed by the bad r1 (L134)
- blow up (L143)

127: (15) if r0 == 0x0 goto pc+1218   ; 
R0=map_value(off=0,ks=4,vs=458752,imm=0)

128: (79) r1 = *(u64 *)(r10 -40)      ; 
R1_w=Pscalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0

129: (35) if r1 >= 0x200 goto pc+1216         ; 
R1_w=Pscalar(umax=511,var_off=(0x0; 0x1ff))

130: (79) r4 = *(u64 *)(r10 -56)      ; R4_w=Pscalar() R10=fp0;

131: (37) r4 /= 1000                  ; R4_w=Pscalar()

132: (79) r1 = *(u64 *)(r10 -40)      ; 
R1_w=Pscalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0;

133: (27) r1 *= 896                   ; 
R1_w=Pscalar(umax=3848290696320,var_off=(0x0; 
0x3ffffffff80),s32_max=2147483520,u32_max=-128)

134: (0f) r0 += r1                    ; 
R0_w=map_value(off=0,ks=4,vs=458752,umax=3848290696320,var_off=(0x0; 
0x3ffffffff80),s32_max=2147483520,u32_max=-128) 
R1_w=Pscalar(umax=3848290696320,var_off=(0x0; 
0x3ffffffff80),s32_max=2147483520,u32_max=-128)

135: (79) r3 = *(u64 *)(r10 -48)      ; 
R3_w=map_value(off=0,ks=4,vs=15728640,imm=0) R10=fp0;

136: (0f) r3 += r8                    ; 
R3_w=map_value(off=0,ks=4,vs=15728640,umax=15728400,var_off=(0x0; 
0xfffff0),s32_max=16777200,u32_max=16777200) 
R8=Pscalar(umax=15728400,var_off=(0x0; 0xfffff0))

137: (61) r1 = *(u32 *)(r7 +16)       ; 
R1_w=Pscalar(umax=4294967295,var_off=(0x0; 0xffffffff)) 
R7=map_value(id=18779,off=0,ks=4,vs=224,imm=0)

138: (79) r2 = *(u64 *)(r3 +88)       ; R2=Pscalar() 
R3=map_value(off=0,ks=4,vs=15728640,umax=15728400,var_off=(0x0; 
0xfffff0),s32_max=16777200,u32_max=16777200)

139: (a5) if r1 < 0x9 goto pc+1       ; 
R1=Pscalar(umin=9,umax=4294967295,var_off=(0x0; 0xffffffff))

140: (b7) r1 = 0                      ; R1_w=P0

141: (27) r1 *= 72                    ; R1_w=P0

142: (0f) r0 += r1                    ; 
R0_w=map_value(off=0,ks=4,vs=458752,umax=3848290696320,var_off=(0x0; 
0x3ffffffff80),s32_max=2147483520,u32_max=-128) R1_w=P0

143: (7b) *(u64 *)(r0 +152) = r2


if i put in a little ASM magic to tell the compiler to not recreate the 
index, it works, like so:

#define BPF_MUST_CHECK(x) ({ asm volatile ("" : "+r"(x)); x; })

#define bpf_array_elem(arr, arr_sz, idx) ({ \
         typeof(&(arr)[0]) ___arr = arr;        \
         typeof(&(arr)[0]) ___ret = 0;          \
         u64 ___idx = idx;                      \
         BPF_MUST_CHECK(___idx);                \
	if (___arr && bpf_cmp_likely(___idx, <, arr_sz))   \
                 ___ret = &___arr[___idx];\
         ___ret;                          \
})

though anecdotally, that only stops the "reread the index from its map" 
problem, similar to a READ_ONCE.  the compiler is still free to just use 
another register for the check.

The bit of ASM i had from a while back that did that was:

  *      r2 = r8
  *      r2 <<= 32 

  *      r2 >>= 32
  *      if r2 > 0x3ff goto pc+29 

  *      r8 <<= 32 

  *      r8 >>= 32 

  *      r8 <<= 6 

  *      r0 += r8
  *      *(u64 *)(r0 +48) = r3 


where r2 was bounds checked, but r8 was used instead.

I'll play around and see if I can come up with a selftest that can run 
into any of these "you did the check, but threw the check away" scenarios.

Thanks,

Barret



