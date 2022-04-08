Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B334F9FCF
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 00:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiDHXBD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 19:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiDHXBC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 19:01:02 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790084ECCA
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 15:58:57 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id k25so12321525iok.8
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 15:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TMxX8ESUWYwRSBY48U4va8AYUKJqwHbhTIoDmIhxLUs=;
        b=FMfJh4EZo9CuapdpTCeDn2ZeKNYZoDnFvnVA0zUO4QhimYO+IlVeHHdWfdViv3Kr6K
         2ZRWa89eVx9ryMKBOq6hTHMAij7ZtIHTqiMZslG5bwpjvy0+06l/XY53FO3g8w1ht1Gh
         KffsdYJ7RW0d/PcTAxJURrPuD5znBi3FDvDs4SUryoudc9AopMC5resHXw05SiIyPE1/
         Q/0t9k7PPJpEMjdgPV8adFGqcN+OH//K5nOSCTrBkAcLBeiyfpjSC8yzzw5bnufXCbAM
         EniXuBiva3fMTZ/35p81Ip2Lm6RoTdDFKsAeK9RpwegglRtJKCwTzjpIfAXF48mLDKhv
         bOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMxX8ESUWYwRSBY48U4va8AYUKJqwHbhTIoDmIhxLUs=;
        b=tblt4ToafbfmEcnfrhJFXxlEKEyh429Wfto135PQwlmp6ZFee3suR1ZywYjDdJMN0V
         tN3RFn6KTm39IVahs6M4qQOkqM6US6ZS4JoJalh6rQFYGPkOtb+qhOzYZLjqBF52wA6M
         yWWlAc5k7KQ942wIw/vyTXyusn7YTTq0IRfhH+ckoh+BBDTvUKkwUg9ZbVgYkXCS0gGN
         t6l3I3NzUxFfiCCii6CVPlvrg5RTLqbWBT1z8bsz+wAcyvf6RpQTABz/jNRefF8P82+n
         1GvqTI4KXExg0h7RzFLu9FvH42k4oiAvqudnwBxfVhNnrEyh3Z0gh/rP1i+TlLfpB7/i
         JNUA==
X-Gm-Message-State: AOAM5303+EjcvumoHN7fbo+93sPIR4XQAawTqJbo8YRw6W3qa4s443yg
        yjjCYjvMRvYGGW1RFKany3YK0vUL2H7+inbZbkU=
X-Google-Smtp-Source: ABdhPJz8jLn7ODnG3HjtnlzcR+Cgl5tF9uCPHKdfP9M5q2M2ry5nqqb3W1Rq9oqT1mEcZ6jABBqAs//rSAqNJG9gU9Y=
X-Received: by 2002:a05:6638:3389:b0:324:2dcb:bb98 with SMTP id
 h9-20020a056638338900b003242dcbbb98mr3856693jav.93.1649458736855; Fri, 08 Apr
 2022 15:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <ceeb6831-7b2e-440b-69d9-3b46c7320b3c@suse.com>
In-Reply-To: <ceeb6831-7b2e-440b-69d9-3b46c7320b3c@suse.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Apr 2022 15:58:46 -0700
Message-ID: <CAEf4BzY6NXqsOVLLiaoGS2vv7S2eNeP1BQFh9cbPffJbf-2X5Q@mail.gmail.com>
Subject: Re: Error validating array access
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 6, 2022 at 5:12 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
> Hello,
>
> I get a validator error with the following function:
>
> #define MAX_PERCPU_BUFSIZE (1<<15)
> #define PATH_MAX 4096
> #define MAX_PATH_COMPONENTS 20
> #define IDX(x) ((x) & (MAX_PERCPU_BUFSIZE-1))
>
> struct buf_t {
>      u8 buf[MAX_PERCPU_BUFSIZE];
> };
>
> struct {
>      __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
>      __uint(max_entries, 1);
>      __type(key, u32);
>      __type(value, struct buf_t);
> } buf_map SEC(".maps");
>
> static __always_inline u32 get_dentry_path_str(struct dentry* dentry,
>          struct buf_t *string_p)
> {
>      const char slash = '/';
>      const int zero = 0;
>
>      u32 buf_off = MAX_PERCPU_BUFSIZE - 1;
>
>      #pragma unroll
>      for (int i = 0; i < MAX_PATH_COMPONENTS; i++) {
>          struct dentry *d_parent = BPF_CORE_READ(dentry, d_parent);
>          if (dentry == d_parent) {
>              break;
>          }
>          // Add this dentry name to path
>          struct qstr d_name = BPF_CORE_READ(dentry, d_name);
>          // Ensure path is no longer than PATH_MAX-1 and copy the terminating NULL
>          unsigned int len = (d_name.len+1) & (PATH_MAX-1);
>          // Start writing from the end of the buffer
>          unsigned int off = buf_off - len;
>          // Is string buffer big enough for dentry name?
>          int sz = 0;
>          // verify no wrap occurred
>          if (off <= buf_off)
>              sz = bpf_probe_read_kernel_str(&string_p->buf[IDX(off)], len, (void *)d_name.name);
>          else
>              break;
>
>          if (sz > 1) {
>              buf_off -= 1; // replace null byte termination with slash sign
>              bpf_probe_read(&(string_p->buf[IDX(buf_off)]), 1, &slash);
>              buf_off -= sz - 1;
>          } else {
>              // If sz is 0 or 1 we have an error (path can't be null nor an empty string)
>              break;
>          }
>          dentry = d_parent;
>      }
>
>      // Add leading slash
>      buf_off -= 1;
>      bpf_probe_read(&(string_p->buf[IDX(buf_off)]), 1, &slash);
>      // Null terminate the path string, this replaces the final / with a null
>      // char
>      bpf_probe_read(&(string_p->buf[MAX_PERCPU_BUFSIZE-1]), 1, &zero);
>      return buf_off;
> }
>
> Here are the last couple of instructions where off is being calculated.
>
> ; unsigned int len = (d_name.len+1) & (PATH_MAX-1);
> 54: (57) r9 &= 4095                   ; R9_w=inv(id=0,umax_value=4095,var_off=(0x0; 0xfff))
> ; unsigned int off = buf_off - len;
> 55: (bf) r8 = r9                      ; R8_w=inv(id=4,umax_value=4095,var_off=(0x0; 0xfff)) R9_w=inv(id=4,umax_value=4095,var_off=(0x0; 0xfff))
> 56: (a7) r8 ^= 32767                  ; R8_w=inv(id=0,umin_value=28672,umax_value=32767,var_off=(0x7000; 0xfff))
> ; sz = bpf_probe_read_kernel_str(&string_p->buf[IDX(off)], len, (void *)d_name.name);
> 57: (79) r6 = *(u64 *)(r10 -72)       ; R6_w=map_value(id=0,off=0,ks=4,vs=32768,imm=0) R10=fp0
> 58: (0f) r6 += r8                     ; R6_w=map_value(id=0,off=0,ks=4,vs=32768,umin_value=28672,umax_value=32767,var_off=(0x7000; 0xfff)) R8_w=invP(id=0,umin_value=28672,umax_value=32767,var_off=(0x7000; 0xfff))
> ; sz = bpf_probe_read_kernel_str(&string_p->buf[IDX(off)], len, (void *)d_name.name);
> 59: (79) r3 = *(u64 *)(r1 +8)         ; R1_w=fp-24 R3_w=inv(id=0)
> ; sz = bpf_probe_read_kernel_str(&string_p->buf[IDX(off)], len, (void *)d_name.name);
> 60: (bf) r1 = r6                      ; R1_w=map_value(id=0,off=0,ks=4,vs=32768,umin_value=28672,umax_value=32767,var_off=(0x7000; 0xfff)) R6_w=map_value(id=0,off=0,ks=4,vs=32768,umin_value=28672,umax_value=32767,var_off=(0x7000; 0xfff))
> 61: (bf) r2 = r9                      ; R2_w=inv(id=4,umax_value=4095,var_off=(0x0; 0xfff)) R9_w=inv(id=4,umax_value=4095,var_off=(0x0; 0xfff))
> 62: (85) call bpf_probe_read_kernel_str#115
> invalid access to map value, value_size=32768 off=32767 size=4095
> R1 max value is outside of the allowed memory range
>
>
>  From what I gathered it seems that in the bpf_probe_read_kernel_str the validator is not
> able to prove that off+len is always going to be at most MAX_PERCPU_BUFSIZE - 1 which is well within
> the bounds of the buffer. My logic goes as following:
>
> buf_off is first set to 32767, we get the first dentry and calculate its len + null terminating char which is going to be at most
> 4095, afterwards 'off' is being calculated as buf_off - len and finally access to the percpu array is performed via  IDX(off) which guarantees the access is
> bounded by MAX_PERCPU_BUFSIZE - 1.

IDX(off) is bounded, but verifier needs to be sure that `off + len`
never goes beyond map value. so you should make sure and prove off <=
MAX_PERCPU_BUFSIZE - PATH_MAX. Verifier actually caught a real bug for
you.

>
> This code was originally based off https://github.com/aquasecurity/tracee/blob/main/pkg/ebpf/c/tracee.bpf.c#L1721-L1777 however it seems
> that the way tracee author work around this is to simply start from the middle of the buffer, i.e set buf_off initially to MAX_PERCPU_BUFSIZE>>1 and adjust the
> array accesses accordingly when doing the masking.
