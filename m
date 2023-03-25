Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AEA6C8F47
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 17:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjCYQC7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 12:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYQC6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 12:02:58 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806CD40F5
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 09:02:57 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id o44so3693424qvo.4
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 09:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679760176;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5sfDoAiYqxBv+cdg/c/Rk8SQ98vFnMWeU/mmyDamvo=;
        b=r/r/mtRA64tiu5fWrNrNhWR8/xsK4LYVU81dXl9iK3B6cd7vnzAOTEIBVY2QFpuZqC
         dPoH8aQP3ggiZmKmkxNVM7yMLkfy+EH1QlE/9iQvthlhBR/cvMu9d8xZp1DNqd7loo3B
         g+9aWHk1BmWvIujthQx80pCzVGFbr8sG32lP0ElKvEaBWbvkb8UvGE/qX27Uyl5Awh+N
         Z15LaPGI8w7TpFYzYTlPJV0MmeoDxn7fpNG80q+Tv3L3uVZ2kJZhgiRynFn4ycWvnYBJ
         +6cLUH5cRn7Jpzqf5kRG5ecBM3Q/CNWO4dPWFiaKKLJrxekT+qKIJoEcF8BN3lgZypt+
         tJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679760176;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y5sfDoAiYqxBv+cdg/c/Rk8SQ98vFnMWeU/mmyDamvo=;
        b=66cBFLYfq1DI498p31lxd3P+mcPLZwb8OnNAmZVDlZ3twU7aQ2/zBYYbjV2YQZVVZu
         CHE+ykEYE9wiVdBV/d7X6a5R/PWJ8x+Q9enyu+Oo0LEhwTmR4Qb5nJjhxlEDIfCn/G5u
         9z90JsTqs0ow8ZKRw7UH2zgVIgN6Zv1AcvLCDXvjOMrKyw8quQoVymCviRWlDaEY+/iS
         Fftz2eFcHzmdYKZGIXDPHIKwu9fAmfl2RiuNM0ErZJpO15kYWRLcg8/ROHyuImIE3CNe
         i0Xnj3WuFnS0yDbO80QTsTXvU1E8rGaFdhJcm8SFgKu1FppnY/oW0wTW53N/qqC1thx7
         uHVw==
X-Gm-Message-State: AAQBX9fOpsTg4e83YQg7W+wka1v0N4JNbCZkwJBiVCY0b1p0zq4IN4HH
        wgaD3dPY/rvdjrOgxxxYIAbYYZp92WxMkblcfPGPxg==
X-Google-Smtp-Source: AKy350ZIrS5qzqIoAzDCVrk4OapZGL2FAdNd/j7vGjRVL3ZEVDAKnGWinfRklH0FPzZV/uTe4JIQmQ==
X-Received: by 2002:a05:6214:2349:b0:5d1:f504:fda9 with SMTP id hu9-20020a056214234900b005d1f504fda9mr9307548qvb.26.1679760176363;
        Sat, 25 Mar 2023 09:02:56 -0700 (PDT)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id mn15-20020a0562145ecf00b005dd8b93458dsm1552132qvb.37.2023.03.25.09.02.55
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 09:02:56 -0700 (PDT)
Message-ID: <1d286b16-4d57-d667-e62c-00d6cb0d956d@google.com>
Date:   Sat, 25 Mar 2023 12:02:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Content-Language: en-US
From:   Barret Rhoden <brho@google.com>
To:     bpf@vger.kernel.org
Subject: inline ASM helpers for proving bounds checks
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi -

i was chatting with a few people off-list and mentioned that i wrote a 
couple helpers for ensuring ints are bounds-checked for things like 
array accesses.  i used inline asm to prevent the compiler from doing 
things like copying the register, checking the copy, and using the 
original for the indexing operation.

i'll paste them below.

if this is the sort of thing that would be nice in one of the helper 
header files, let me know where you'd like it and i can send a patch.

thanks,

barret


/*
  * Returns pointer to idx element in the array arr, made of
  * arr_sz number of elements:
  *
  *      if (!arr)
  *              return NULL;
  *      if (idx >= arr_sz)
  *              return NULL; 

  *      return &arr[idx];
  */
#define BOUNDED_ARRAY_IDX(arr, arr_sz, idx) ({      \
         typeof(&(arr)[0]) ___arr = arr;             \
         u64 ___idx = idx;                           \
         if (___arr) {                               \
                 asm volatile("if %[__idx] >= %[__bound] goto 1f;\
                               %[__idx] *= %[__size];            \
                               %[__arr] += %[__idx];             \
                               goto 2f;                          \
                               1:;                               \
                               %[__arr] = 0;                     \
                               2:                                \
                               "                                 \
                              : [__arr]"+r"(___arr), [__idx]"+r"(___idx)\
                              : [__bound]"i"((arr_sz)),                 \
                                [__size]"i"(sizeof(typeof((arr)[0])))   \
                              : "cc");                                  \
         }                                                              \
         ___arr;                                                        \
})


/*
  * Forces the verifier to ensure idx is less than bound.  Returns 0 if
  * idx is not less than bound.
  */
static inline size_t bounded_idx(size_t idx, int bound)
{
         asm volatile("if %[__idx] < %[__bound] goto 1f; \
                       %[__idx] = 0;                     \
                       1:"
                       : [__idx]"+r"(idx) : [__bound]"i"(bound) : "cc");
         return idx;
}

this one is a little simpler, but also more dangerous.  if the int isn't 
actually bounded, it'll set it to 0, which might not be what you want 
since you can't tell the difference between "out of bounds" and 
"actually 0".  i use this in a place where i know the int is bounded 
(barring other horrendous bugs) and can't check.


