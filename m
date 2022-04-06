Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DF84F6C2C
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 23:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiDFVKu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 17:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbiDFVKj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 17:10:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9749639A
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 12:51:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 239FA1F38A
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 19:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649274687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JDK6dzOJxQlpKj87nJFxkZGKaiwcDhjjbeYfr7PnKnQ=;
        b=TyRxDDG0Rw44IrHmp6f4UVBXXQRyoqkq92kR+Uv/yifm4PBnQz3NfbTvwRkXErKhRwwp6n
        UUhtHApZ6WLaM1ASHxxz4C/bzpKSnJYsDhSmWarDd7E5DYTlsgamkruZ3ck6tEeEBv7G4q
        sBCPbOXAEi0QS6FgJkyO5x/axs0zxk0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 016D613A8E
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 19:51:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kl3POD7vTWK2HgAAMHmgww
        (envelope-from <nborisov@suse.com>)
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 19:51:26 +0000
Message-ID: <ceeb6831-7b2e-440b-69d9-3b46c7320b3c@suse.com>
Date:   Wed, 6 Apr 2022 22:51:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     bpf <bpf@vger.kernel.org>
From:   Nikolay Borisov <nborisov@suse.com>
Subject: Error validating array access
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I get a validator error with the following function:

#define MAX_PERCPU_BUFSIZE (1<<15)
#define PATH_MAX 4096
#define MAX_PATH_COMPONENTS 20
#define IDX(x) ((x) & (MAX_PERCPU_BUFSIZE-1))
                                                                                 
struct buf_t {
     u8 buf[MAX_PERCPU_BUFSIZE];
};
                                                                                                                                                                 
struct {
     __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
     __uint(max_entries, 1);
     __type(key, u32);
     __type(value, struct buf_t);
} buf_map SEC(".maps");
                                                         
static __always_inline u32 get_dentry_path_str(struct dentry* dentry,
         struct buf_t *string_p)
{
     const char slash = '/';
     const int zero = 0;
                                                                                 
     u32 buf_off = MAX_PERCPU_BUFSIZE - 1;
                                                                                 
     #pragma unroll
     for (int i = 0; i < MAX_PATH_COMPONENTS; i++) {
         struct dentry *d_parent = BPF_CORE_READ(dentry, d_parent);
         if (dentry == d_parent) {
             break;
         }
         // Add this dentry name to path
         struct qstr d_name = BPF_CORE_READ(dentry, d_name);
         // Ensure path is no longer than PATH_MAX-1 and copy the terminating NULL
         unsigned int len = (d_name.len+1) & (PATH_MAX-1);
         // Start writing from the end of the buffer
         unsigned int off = buf_off - len;
         // Is string buffer big enough for dentry name?
         int sz = 0;
         // verify no wrap occurred
         if (off <= buf_off)
             sz = bpf_probe_read_kernel_str(&string_p->buf[IDX(off)], len, (void *)d_name.name);
         else
             break;
                                                                                 
         if (sz > 1) {
             buf_off -= 1; // replace null byte termination with slash sign
             bpf_probe_read(&(string_p->buf[IDX(buf_off)]), 1, &slash);
             buf_off -= sz - 1;
         } else {
             // If sz is 0 or 1 we have an error (path can't be null nor an empty string)
             break;
         }
         dentry = d_parent;
     }
                                                                                 
     // Add leading slash
     buf_off -= 1;
     bpf_probe_read(&(string_p->buf[IDX(buf_off)]), 1, &slash);
     // Null terminate the path string, this replaces the final / with a null
     // char
     bpf_probe_read(&(string_p->buf[MAX_PERCPU_BUFSIZE-1]), 1, &zero);
     return buf_off;
}

Here are the last couple of instructions where off is being calculated.

; unsigned int len = (d_name.len+1) & (PATH_MAX-1);
54: (57) r9 &= 4095                   ; R9_w=inv(id=0,umax_value=4095,var_off=(0x0; 0xfff))
; unsigned int off = buf_off - len;
55: (bf) r8 = r9                      ; R8_w=inv(id=4,umax_value=4095,var_off=(0x0; 0xfff)) R9_w=inv(id=4,umax_value=4095,var_off=(0x0; 0xfff))
56: (a7) r8 ^= 32767                  ; R8_w=inv(id=0,umin_value=28672,umax_value=32767,var_off=(0x7000; 0xfff))
; sz = bpf_probe_read_kernel_str(&string_p->buf[IDX(off)], len, (void *)d_name.name);
57: (79) r6 = *(u64 *)(r10 -72)       ; R6_w=map_value(id=0,off=0,ks=4,vs=32768,imm=0) R10=fp0
58: (0f) r6 += r8                     ; R6_w=map_value(id=0,off=0,ks=4,vs=32768,umin_value=28672,umax_value=32767,var_off=(0x7000; 0xfff)) R8_w=invP(id=0,umin_value=28672,umax_value=32767,var_off=(0x7000; 0xfff))
; sz = bpf_probe_read_kernel_str(&string_p->buf[IDX(off)], len, (void *)d_name.name);
59: (79) r3 = *(u64 *)(r1 +8)         ; R1_w=fp-24 R3_w=inv(id=0)
; sz = bpf_probe_read_kernel_str(&string_p->buf[IDX(off)], len, (void *)d_name.name);
60: (bf) r1 = r6                      ; R1_w=map_value(id=0,off=0,ks=4,vs=32768,umin_value=28672,umax_value=32767,var_off=(0x7000; 0xfff)) R6_w=map_value(id=0,off=0,ks=4,vs=32768,umin_value=28672,umax_value=32767,var_off=(0x7000; 0xfff))
61: (bf) r2 = r9                      ; R2_w=inv(id=4,umax_value=4095,var_off=(0x0; 0xfff)) R9_w=inv(id=4,umax_value=4095,var_off=(0x0; 0xfff))
62: (85) call bpf_probe_read_kernel_str#115
invalid access to map value, value_size=32768 off=32767 size=4095
R1 max value is outside of the allowed memory range
       

 From what I gathered it seems that in the bpf_probe_read_kernel_str the validator is not
able to prove that off+len is always going to be at most MAX_PERCPU_BUFSIZE - 1 which is well within
the bounds of the buffer. My logic goes as following:

buf_off is first set to 32767, we get the first dentry and calculate its len + null terminating char which is going to be at most
4095, afterwards 'off' is being calculated as buf_off - len and finally access to the percpu array is performed via  IDX(off) which guarantees the access is
bounded by MAX_PERCPU_BUFSIZE - 1.

This code was originally based off https://github.com/aquasecurity/tracee/blob/main/pkg/ebpf/c/tracee.bpf.c#L1721-L1777 however it seems
that the way tracee author work around this is to simply start from the middle of the buffer, i.e set buf_off initially to MAX_PERCPU_BUFSIZE>>1 and adjust the
array accesses accordingly when doing the masking.
