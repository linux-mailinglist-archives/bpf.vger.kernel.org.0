Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364F924E70A
	for <lists+bpf@lfdr.de>; Sat, 22 Aug 2020 13:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgHVL1e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Aug 2020 07:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgHVL1e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Aug 2020 07:27:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9374FC061573
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2020 04:27:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b17so3426345wru.2
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2020 04:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SqucJSM8lVFremZ/k8YWdHGlrJ2OpwyubXA0nw8/Qxg=;
        b=UI1aIyjrwrkIIERBV9FLe+Bx10AP87eBi7hRt5AmbLL9Z6b8jnALKmTj9RkraQial/
         WL+d40BZHowlk+15yD0qKhc7pa+epTMuy7G16houx1q9TSKwY7uX2vpuaeQ96mkgMaMa
         rU3eyJq2rlC25s93klDfF3lF4pgaoepIuJnRwMLpMCe48rcSCpc+gR0gkpN2kdHNNYMm
         6lSDjLQR8QaTOfJdzqg4OxBhl1tquieWdvlfegKlIEAmLcW2Y5FxGhJgmMjIJ0Uqad6K
         l2ayMI0WxxR/9VCCPa5W7XHEJt6N37AQ3KG0VnkAVrcCE8dNGu59FNOcHBZLOIySGQhZ
         BtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SqucJSM8lVFremZ/k8YWdHGlrJ2OpwyubXA0nw8/Qxg=;
        b=STIhbn7Ik8Jvytn4m7/ccGz/4O7eMnQ4w0ry86ZGCXyjDbGiboXnhCSF0/GpfNQzMD
         Y84Np/S3auC6JDp6shinTj/A5hl8sOuH/CQBsZ97vDWP0aXwK5NdJpviJOIgzryppeS4
         64gyeuwFWAqBYOFEUxlnEzLrZHzswUh+NWaGiNYxXOJVCVDgxF+lPWOM5uOIp7lyevbc
         XsMP7KRejFF/06cYGVL0OcEkIJdXtglpqi4b066uPyjXiZxT0yULQjRA7xkpyYYrjgaj
         iLvlOVMgQrO4EI4NEjobZ98RHAQiCb7hxu+WozYoE7gFrnbJ9Wjs3EWROyF48phxWc+C
         w1mw==
X-Gm-Message-State: AOAM531BzDiW/vVMw7GsGF/dDPppha2rJg9D7z0zCVnTC3dN4DZ/V5D8
        AcsbPPXqEOvIoAYhD9z3qek=
X-Google-Smtp-Source: ABdhPJxT+TsDMVfwnRNvJLUZalQYYubDl6rrcpEGUvqx935Y7DVghOZ5dkzTR69C8coFGEXaoZqgSw==
X-Received: by 2002:a5d:410e:: with SMTP id l14mr1834621wrp.216.1598095651318;
        Sat, 22 Aug 2020 04:27:31 -0700 (PDT)
Received: from localhost.localdomain (109-186-63-251.bb.netvision.net.il. [109.186.63.251])
        by smtp.googlemail.com with ESMTPSA id j11sm10167003wrq.69.2020.08.22.04.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 04:27:30 -0700 (PDT)
From:   Lior Ribak <liorribak@gmail.com>
To:     yhs@fb.com
Cc:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@chromium.org, liorribak@gmail.com, songliubraving@fb.com
Subject: Re: [PATCH] samples/bpf: Support both enter and exit kprobes in helper
Date:   Sat, 22 Aug 2020 04:27:13 -0700
Message-Id: <20200822112713.317226-1-liorribak@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <99122200-5308-25c0-cc4f-145847ef7edb@fb.com>
References: <99122200-5308-25c0-cc4f-145847ef7edb@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/15/20 11:02 PM, Yonghong Song wrote:
>On 8/15/20 12:57 PM, Lior Ribak wrote:
>> Currently, in bpf_load.c, the function write_kprobe_events sets
>> the function name to probe as the probe name.
>> Even though it's valid to set one kprobe on enter and another on exit,
>> bpf_load.c won't handle it, and will return an error 'File exists'.
>> 
>> Add a prefix to the event name to indicate if it's on enter or exit,
>> so both an enter and an exit kprobes can be attached.

>
>Only bpf_load.c change and no users here. So do you imply that
>use use this piece code in your own environment some how? But in
>that case, not sure whether this patch is necessary or not.
>
>The change here is for legacy bpf_load which may go away in the future.
>I understand this is for debugfs based kprobe_events where current
>libbpf does not support. But if possible, you should upgrade to use
>fd-based kprobe which is introduced roughly in/around 4.17 and libbpf 
>has proper support.

I used the samples and it's toolchain to write my own bpf, so i wrote this
patch to save the trouble to the next one who will try to register 2 
kprobes on the same function.
I still suggest to apply the patch because it solves a bug.

As I see it, all the wrappers around ebpf are duplicated everywhere, and
fd-based krpobe is already wrapped in the bcc project, so if you suggest
to switch and use it, maybe it's better to import some of the code from 
bcc instead

>
>> 
>> Signed-off-by: Lior Ribak <liorribak@gmail.com>
>> ---
>>   samples/bpf/bpf_load.c | 20 +++++++++++++-------
>>   1 file changed, 13 insertions(+), 7 deletions(-)
>> 
>> diff --git a/samples/bpf/bpf_load.c b/samples/bpf/bpf_load.c
>> index c5ad528f046e..69102358e91a 100644
>> --- a/samples/bpf/bpf_load.c
>> +++ b/samples/bpf/bpf_load.c
>> @@ -184,18 +184,24 @@ static int load_and_attach(const char *event, struct bpf_insn *prog, int size)
>>   
>>   #ifdef __x86_64__
>>           if (strncmp(event, "sys_", 4) == 0) {
>> -         snprintf(buf, sizeof(buf), "%c:__x64_%s __x64_%s",
>> -             is_kprobe ? 'p' : 'r', event, event);
>> +         if (is_kprobe)
>> +             event_prefix = "__x64_enter_";
>> +         else
>> +             event_prefix = "__x64_exit_";
>> +         snprintf(buf, sizeof(buf), "%c:%s%s __x64_%s",
>> +             is_kprobe ? 'p' : 'r', event_prefix, event, event);
>>               err = write_kprobe_events(buf);
>> -         if (err >= 0) {
>> +         if (err >= 0)
>>                   need_normal_check = false;
>> -             event_prefix = "__x64_";
>> -         }
>>           }
>>   #endif
>>           if (need_normal_check) {
>> -         snprintf(buf, sizeof(buf), "%c:%s %s",
>> -             is_kprobe ? 'p' : 'r', event, event);
>> +         if (is_kprobe)
>> +             event_prefix = "enter_";
>> +         else
>> +             event_prefix = "exit_";
>> +         snprintf(buf, sizeof(buf), "%c:%s%s %s",
>> +             is_kprobe ? 'p' : 'r', event_prefix, event, event);
>>               err = write_kprobe_events(buf);
>>               if (err < 0) {
>>                   printf("failed to create kprobe '%s' error '%s'\n",
>> 
