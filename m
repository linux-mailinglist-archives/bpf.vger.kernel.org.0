Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC184FA56A
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 08:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbiDIG3o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Apr 2022 02:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240108AbiDIG3n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Apr 2022 02:29:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDAE1EC46
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 23:27:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8B449210DD;
        Sat,  9 Apr 2022 06:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649485649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cu4i4G2gw3oNpdgHP4mpqpxbauPFZAjd92YEVTbkDzs=;
        b=LRoKh+Z9BZGeWfxwURQf3Fu+op9a4jJNBZfgn78ogpY5pzp0Ac8FA7krAVv5EhTocmf0jf
        IioVOj2fQ7pc3xerPPOmHDVEXzrdvJBJPaVr69tnHJ/zsFItBX8QEoGNCRiCrAcMOvkDrr
        X4Rv5gr6Gu0NiyLqCIMb4/LSdvK1KkY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D3AC13AA1;
        Sat,  9 Apr 2022 06:27:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FbmhE1EnUWIjOQAAMHmgww
        (envelope-from <nborisov@suse.com>); Sat, 09 Apr 2022 06:27:29 +0000
Message-ID: <7e7b5534-934c-f0fc-11c0-1d00560a4100@suse.com>
Date:   Sat, 9 Apr 2022 09:27:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Error validating array access
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <ceeb6831-7b2e-440b-69d9-3b46c7320b3c@suse.com>
 <CAEf4BzY6NXqsOVLLiaoGS2vv7S2eNeP1BQFh9cbPffJbf-2X5Q@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <CAEf4BzY6NXqsOVLLiaoGS2vv7S2eNeP1BQFh9cbPffJbf-2X5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9.04.22 г. 1:58 ч., Andrii Nakryiko wrote:
> On Wed, Apr 6, 2022 at 5:12 PM Nikolay Borisov <nborisov@suse.com> wrote:
>>
>> Hello,
>>
>> I get a validator error with the following function:
>>
>> #define MAX_PERCPU_BUFSIZE (1<<15)
>> #define PATH_MAX 4096
>> #define MAX_PATH_COMPONENTS 20
>> #define IDX(x) ((x) & (MAX_PERCPU_BUFSIZE-1))
>>
>> struct buf_t {
>>       u8 buf[MAX_PERCPU_BUFSIZE];
>> };
>>
>> struct {
>>       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
>>       __uint(max_entries, 1);
>>       __type(key, u32);
>>       __type(value, struct buf_t);
>> } buf_map SEC(".maps");
>>
>> static __always_inline u32 get_dentry_path_str(struct dentry* dentry,
>>           struct buf_t *string_p)
>> {
>>       const char slash = '/';
>>       const int zero = 0;
>>
>>       u32 buf_off = MAX_PERCPU_BUFSIZE - 1;
>>
>>       #pragma unroll
>>       for (int i = 0; i < MAX_PATH_COMPONENTS; i++) {
>>           struct dentry *d_parent = BPF_CORE_READ(dentry, d_parent);
>>           if (dentry == d_parent) {
>>               break;
>>           }
>>           // Add this dentry name to path
>>           struct qstr d_name = BPF_CORE_READ(dentry, d_name);
>>           // Ensure path is no longer than PATH_MAX-1 and copy the terminating NULL
>>           unsigned int len = (d_name.len+1) & (PATH_MAX-1);
>>           // Start writing from the end of the buffer
>>           unsigned int off = buf_off - len;
>>           // Is string buffer big enough for dentry name?
>>           int sz = 0;
>>           // verify no wrap occurred
>>           if (off <= buf_off)
>>               sz = bpf_probe_read_kernel_str(&string_p->buf[IDX(off)], len, (void *)d_name.name);
>>           else
>>               break;
>>
>>           if (sz > 1) {
>>               buf_off -= 1; // replace null byte termination with slash sign
>>               bpf_probe_read(&(string_p->buf[IDX(buf_off)]), 1, &slash);
>>               buf_off -= sz - 1;
>>           } else {
>>               // If sz is 0 or 1 we have an error (path can't be null nor an empty string)
>>               break;
>>           }
>>           dentry = d_parent;
>>       }
>>
>>       // Add leading slash
>>       buf_off -= 1;
>>       bpf_probe_read(&(string_p->buf[IDX(buf_off)]), 1, &slash);
>>       // Null terminate the path string, this replaces the final / with a null
>>       // char
>>       bpf_probe_read(&(string_p->buf[MAX_PERCPU_BUFSIZE-1]), 1, &zero);
>>       return buf_off;
>> }
>>
>> Here are the last couple of instructions where off is being calculated.
>>
>> ; unsigned int len = (d_name.len+1) & (PATH_MAX-1);
>> 54: (57) r9 &= 4095                   ; R9_w=inv(id=0,umax_value=4095,var_off=(0x0; 0xfff))
>> ; unsigned int off = buf_off - len;
>> 55: (bf) r8 = r9                      ; R8_w=inv(id=4,umax_value=4095,var_off=(0x0; 0xfff)) R9_w=inv(id=4,umax_value=4095,var_off=(0x0; 0xfff))
>> 56: (a7) r8 ^= 32767                  ; R8_w=inv(id=0,umin_value=28672,umax_value=32767,var_off=(0x7000; 0xfff))
>> ; sz = bpf_probe_read_kernel_str(&string_p->buf[IDX(off)], len, (void *)d_name.name);
>> 57: (79) r6 = *(u64 *)(r10 -72)       ; R6_w=map_value(id=0,off=0,ks=4,vs=32768,imm=0) R10=fp0
>> 58: (0f) r6 += r8                     ; R6_w=map_value(id=0,off=0,ks=4,vs=32768,umin_value=28672,umax_value=32767,var_off=(0x7000; 0xfff)) R8_w=invP(id=0,umin_value=28672,umax_value=32767,var_off=(0x7000; 0xfff))
>> ; sz = bpf_probe_read_kernel_str(&string_p->buf[IDX(off)], len, (void *)d_name.name);
>> 59: (79) r3 = *(u64 *)(r1 +8)         ; R1_w=fp-24 R3_w=inv(id=0)
>> ; sz = bpf_probe_read_kernel_str(&string_p->buf[IDX(off)], len, (void *)d_name.name);
>> 60: (bf) r1 = r6                      ; R1_w=map_value(id=0,off=0,ks=4,vs=32768,umin_value=28672,umax_value=32767,var_off=(0x7000; 0xfff)) R6_w=map_value(id=0,off=0,ks=4,vs=32768,umin_value=28672,umax_value=32767,var_off=(0x7000; 0xfff))
>> 61: (bf) r2 = r9                      ; R2_w=inv(id=4,umax_value=4095,var_off=(0x0; 0xfff)) R9_w=inv(id=4,umax_value=4095,var_off=(0x0; 0xfff))
>> 62: (85) call bpf_probe_read_kernel_str#115
>> invalid access to map value, value_size=32768 off=32767 size=4095
>> R1 max value is outside of the allowed memory range
>>
>>
>>   From what I gathered it seems that in the bpf_probe_read_kernel_str the validator is not
>> able to prove that off+len is always going to be at most MAX_PERCPU_BUFSIZE - 1 which is well within
>> the bounds of the buffer. My logic goes as following:
>>
>> buf_off is first set to 32767, we get the first dentry and calculate its len + null terminating char which is going to be at most
>> 4095, afterwards 'off' is being calculated as buf_off - len and finally access to the percpu array is performed via  IDX(off) which guarantees the access is
>> bounded by MAX_PERCPU_BUFSIZE - 1.
> 
> IDX(off) is bounded, but verifier needs to be sure that `off + len`
> never goes beyond map value. so you should make sure and prove off <=
> MAX_PERCPU_BUFSIZE - PATH_MAX. Verifier actually caught a real bug for

But that is guaranteed since off = buff_off - len, and buf_off is 
guaranteed to be at most MAX_PERCPU_BUFSIZE -1, meaning off is in the 
worst case MAX_PERCPU_BUFSIZE - len  so the map value access can't go 
beyond the end ?

> you.
> 
>>
>> This code was originally based off https://github.com/aquasecurity/tracee/blob/main/pkg/ebpf/c/tracee.bpf.c#L1721-L1777 however it seems
>> that the way tracee author work around this is to simply start from the middle of the buffer, i.e set buf_off initially to MAX_PERCPU_BUFSIZE>>1 and adjust the
>> array accesses accordingly when doing the masking.
> 
