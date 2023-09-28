Return-Path: <bpf+bounces-11048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42807B1F2D
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 16:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 66112282450
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 14:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB113CCE6;
	Thu, 28 Sep 2023 14:04:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E7838BCD
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 14:04:09 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E688F19D
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 07:04:07 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32336a30d18so4990419f8f.2
        for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695909846; x=1696514646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IdCzUZTyrhLyuWRrO5KbCvUfljCQ/8lY8UrbbuS8PLI=;
        b=kF9J/FpxoDdoItDeZ9dplXQ0lsiAaY5tHeyXoGrh1gdmpy4DvZtCPQ7jAVk+TdxAOY
         ZMpxMWo4ySRnbQpEZNaljXBhe8k7pCaWO8XRnbrJWKSFuYhPqwRBGICof4JMQrKTxH9Y
         mAntTM2OYMe0rCPLxWWjB1Sih/RMD4HCZn85lI0NR6RxYcJ6o2mq69pi2y4tVz5fZm/U
         TfjHxa8Q/hRxTIGQ/fyJk4Z+0v9XnlRVtEJg/vj45lQpGhFCzdLnWAjWQvNQDwiQR5uN
         WIrMBNWHTK0sBj4tWceC1Z/jXQX79V6w1o4CupjL0MP6aincE/+Ue8hqZQjPJQ5mIii3
         qZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695909846; x=1696514646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdCzUZTyrhLyuWRrO5KbCvUfljCQ/8lY8UrbbuS8PLI=;
        b=u1fu4+ytpigrOQHBrqFN9XXSnutu2Kb69z3NeVjXnm1hWk4NjP2yDCne7yXzKbxZqA
         Bg9xRfcMqdNWvs5TpWtIBFlYn5MDnBMmeoMg9qG/ominEHy5dcaSJ/E6m6zFOICPOpQD
         4fJz77VkUAIFZxUkU9JaYc00XiwPhM0od/61ICD4Dm+pRQqi6OEZV7cKV/KepQvuldEq
         nKBAiPWpUB7Ai9XkHgkDdVYQHDn544+DCPzrEat73Cb7WajUHzQQbZszQrUUVHz820KB
         or1GxXgRRk/f81ly573SpSL1merFX/8L6ky3Xp1GjvolMWirCflejZ6TAabG3PU3CkGB
         GbBw==
X-Gm-Message-State: AOJu0YzHoX2Ecch8tF7S3LCJTkEuiOUR0866NvwZEjCnAbURO/kTt11F
	snrvDFotgtbtccmRv8WH97w=
X-Google-Smtp-Source: AGHT+IGaNdBt0UkWwXqJ9AS0cDlExHjV6eIN2SLCqWPqPM/b3FAzebWdKQYNuZx9G9wYbasqHptVhg==
X-Received: by 2002:a5d:4006:0:b0:317:50b7:2ce3 with SMTP id n6-20020a5d4006000000b0031750b72ce3mr1383156wrp.51.1695909845375;
        Thu, 28 Sep 2023 07:04:05 -0700 (PDT)
Received: from krava ([83.240.63.128])
        by smtp.gmail.com with ESMTPSA id l16-20020a5d4bd0000000b003216a068d2csm19462292wrt.24.2023.09.28.07.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 07:04:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 28 Sep 2023 16:03:31 +0200
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: Jiri Olsa <olsajiri@gmail.com>, ruowenq2@illinois.edu,
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, keescook@chromium.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Jinghao Jia <jinghao@linux.ibm.com>
Subject: Re: [PATCH bpf-next v3 1/1] samples/bpf: Add -fsanitize=bounds to
 userspace programs
Message-ID: <ZRWHs3fiCZZWGTWq@krava>
References: <20230927045030.224548-1-ruowenq2@illinois.edu>
 <20230927045030.224548-2-ruowenq2@illinois.edu>
 <ZRQMASduySxE+TO2@krava>
 <ed2a63a4-434c-4cf7-ad27-c17f75bbdf84@illinois.edu>
 <ZRU2M3wlFDpljnZq@krava>
 <299340fa-a7dc-4b56-8f5e-da058b343386@illinois.edu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <299340fa-a7dc-4b56-8f5e-da058b343386@illinois.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 04:19:02AM -0500, Jinghao Jia wrote:
> 
> 
> On 9/28/23 3:15 AM, Jiri Olsa wrote:
> > On Wed, Sep 27, 2023 at 06:19:10PM -0500, ruowenq2@illinois.edu wrote:
> >>
> >>
> >> On 9/27/23 6:03 AM, Jiri Olsa <olsajiri@gmail.com> wrote:
> >>> On Tue, Sep 26, 2023 at 11:50:30PM -0500, ruowenq2@illinois.edu wrote:
> >>>> From: Ruowen Qin <ruowenq2@illinois.edu>
> >>>>
> >>>> The sanitizer flag, which is supported by both clang and gcc, would make
> >>>> it easier to debug array index out-of-bounds problems in these programs.
> >>>>
> >>>> Make the Makfile smarter to detect ubsan support from the compiler and
> >>>> add the '-fsanitize=bounds' accordingly.
> >>>>
> >>>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> >>>> Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
> >>>> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
> >>>> Signed-off-by: Ruowen Qin <ruowenq2@illinois.edu>
> >>>> ---
> >>>>   samples/bpf/Makefile | 3 +++
> >>>>   1 file changed, 3 insertions(+)
> >>>>
> >>>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> >>>> index 6c707ebcebb9..90af76fa9dd8 100644
> >>>> --- a/samples/bpf/Makefile
> >>>> +++ b/samples/bpf/Makefile
> >>>> @@ -169,6 +169,9 @@ endif
> >>>>   TPROGS_CFLAGS += -Wall -O2
> >>>>   TPROGS_CFLAGS += -Wmissing-prototypes
> >>>>   TPROGS_CFLAGS += -Wstrict-prototypes
> >>>> +TPROGS_CFLAGS += $(call try-run,\
> >>>> +	printf "int main() { return 0; }" |\
> >>>> +	$(CC) -Werror -fsanitize=bounds -x c - -o "$$TMP",-fsanitize=bounds,)
> >>>
> >>> I haven't checked deeply, but could we use just cc-option? looks simpler
> >>>
> >>> TPROGS_CFLAGS += $(call cc-option, -fsanitize=bounds)
> >>>
> >>> jirka
> >>
> >> Hi, thanks for your quick reply! When checking for flags, cc-option does not execute the linker, but on Fedora, an error appears and stating that "/usr/lib64/libubsan.so.1.0.0" cannot be found during linking. So I try this seemingly cumbersome way.
> > 
> > I see, there's also ld-option, would that work?
> > 
> > jirka
> > 
> 
> IMHO I don't think ld-option would solve the problem. It directly sends the
> flag to the linker but -fsanitize=bounds is a compiler flag, not a linker
> flag.
> 
> Basically, what's special about this case is that the feature we want to
> probe is behind a gcc/clang flag but we do not know whether it is supported
> until link time (e.g. the sanitizer library is missing on Fedora so we get
> a link error).

ok, I tested on fedora, looks good

Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> --Jinghao
> 
> >>
> >> Ruowen
> >>
> >>>>   >   TPROGS_CFLAGS += -I$(objtree)/usr/include
> >>>>   TPROGS_CFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
> >>>> -- > 2.42.0
> >>>>
> >>>>
> >>>

