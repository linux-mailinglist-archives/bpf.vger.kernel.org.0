Return-Path: <bpf+bounces-11017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D197B15CC
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 10:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 86A66282880
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 08:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB87328D9;
	Thu, 28 Sep 2023 08:15:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C25F1FD5
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 08:15:54 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C6998
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 01:15:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so1568924466b.3
        for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 01:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695888951; x=1696493751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9UeGQ9En9rIK4hkvkXFvox+LJzbN2Nw5Y2M1vKc37Y=;
        b=ZBBFUs7+tuCywAVBgzeoDKLmWoVuO/aRAUwu9QDQDk090iN4m/5txh5hPAgdsW1VlN
         TzVpWhsHC7zfhMH8aUjKmcCmABn3MzOr9tVO2xPOO2tG6NXBHoRLVp8aqz/xlihP50c+
         y5DDulA6O1XVEnwF09Hg3qUvmolkg9DOrzaJygqlFSycIJ83Lt1oAoZX7YmdhwiOKgSd
         UrSjj4G1zxreU7QWiUwLACyfMJwrE+Mk3HxK+FIYj3ScEE6f0ZPEPkaAX2uNoRPQaW7s
         ke3Q6Apj69rJpV9mCNzU1YEzX3xwuux/OqNqSykpZa3ZVHOH8cW2KYVzf/SsETFUlcJz
         stLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695888951; x=1696493751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9UeGQ9En9rIK4hkvkXFvox+LJzbN2Nw5Y2M1vKc37Y=;
        b=Xe3J77+h0ShcwHZwW9iPa5eWuHtUWSfacuV/uHqbVfi96rf61XHDkj7UZZPx82HQUJ
         /tmm1LqaGNXZtl9IM8py1vo/dHfgGR+UADN1OWFtkglcKq1R3KL2K51HNXf9BeZ5uFxn
         vRdg496Kwktl+tHpN9Gv+0S9vCamA0DjFXrDE5/KnWplG1iyjDKqPrjx8XQ1vksBUD0c
         dqiqdbZ8UpBJk4O64PI4EpJDYtGfn+8pAaOnHNf+YjzeXH7SifVayMDi/csJgYwZ6qUn
         DFAKXCfyoUhYere+5o+fb/sy+MHv5dF1q8WSQQUmuyFKbb4kobxWSus+m+/m9NSxOIXh
         94Lw==
X-Gm-Message-State: AOJu0Yxfn+W38Dql19+gy3GyPQzqKoGYTF4mSrRu6jwA4dOR4D/BC1dF
	WPenZIyvxgYhusgrWBzCCxI=
X-Google-Smtp-Source: AGHT+IE/VooMn35oo2E+muvd7TNuvSe0wiqtj+nfbCE5HF9LFf3wRm+R9t62OCwwgLzUUgF0WJchkw==
X-Received: by 2002:a17:906:32cb:b0:9a2:232f:6f85 with SMTP id k11-20020a17090632cb00b009a2232f6f85mr481430ejk.52.1695888950464;
        Thu, 28 Sep 2023 01:15:50 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id qq23-20020a17090720d700b00993664a9987sm10422415ejb.103.2023.09.28.01.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 01:15:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 28 Sep 2023 10:15:47 +0200
To: ruowenq2@illinois.edu
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, jinghao7@illinois.edu,
	keescook@chromium.org, Mimi Zohar <zohar@linux.ibm.com>,
	Jinghao Jia <jinghao@linux.ibm.com>
Subject: Re: [PATCH bpf-next v3 1/1] samples/bpf: Add -fsanitize=bounds to
 userspace programs
Message-ID: <ZRU2M3wlFDpljnZq@krava>
References: <20230927045030.224548-1-ruowenq2@illinois.edu>
 <20230927045030.224548-2-ruowenq2@illinois.edu>
 <ZRQMASduySxE+TO2@krava>
 <ed2a63a4-434c-4cf7-ad27-c17f75bbdf84@illinois.edu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed2a63a4-434c-4cf7-ad27-c17f75bbdf84@illinois.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 06:19:10PM -0500, ruowenq2@illinois.edu wrote:
> 
> 
> On 9/27/23 6:03 AM, Jiri Olsa <olsajiri@gmail.com> wrote:
> > On Tue, Sep 26, 2023 at 11:50:30PM -0500, ruowenq2@illinois.edu wrote:
> > > From: Ruowen Qin <ruowenq2@illinois.edu>
> > >
> > > The sanitizer flag, which is supported by both clang and gcc, would make
> > > it easier to debug array index out-of-bounds problems in these programs.
> > >
> > > Make the Makfile smarter to detect ubsan support from the compiler and
> > > add the '-fsanitize=bounds' accordingly.
> > >
> > > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
> > > Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
> > > Signed-off-by: Ruowen Qin <ruowenq2@illinois.edu>
> > > ---
> > >   samples/bpf/Makefile | 3 +++
> > >   1 file changed, 3 insertions(+)
> > >
> > > diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> > > index 6c707ebcebb9..90af76fa9dd8 100644
> > > --- a/samples/bpf/Makefile
> > > +++ b/samples/bpf/Makefile
> > > @@ -169,6 +169,9 @@ endif
> > >   TPROGS_CFLAGS += -Wall -O2
> > >   TPROGS_CFLAGS += -Wmissing-prototypes
> > >   TPROGS_CFLAGS += -Wstrict-prototypes
> > > +TPROGS_CFLAGS += $(call try-run,\
> > > +	printf "int main() { return 0; }" |\
> > > +	$(CC) -Werror -fsanitize=bounds -x c - -o "$$TMP",-fsanitize=bounds,)
> > 
> > I haven't checked deeply, but could we use just cc-option? looks simpler
> > 
> > TPROGS_CFLAGS += $(call cc-option, -fsanitize=bounds)
> > 
> > jirka
> 
> Hi, thanks for your quick reply! When checking for flags, cc-option does not execute the linker, but on Fedora, an error appears and stating that "/usr/lib64/libubsan.so.1.0.0" cannot be found during linking. So I try this seemingly cumbersome way.

I see, there's also ld-option, would that work?

jirka

> 
> Ruowen
> 
> > >   >   TPROGS_CFLAGS += -I$(objtree)/usr/include
> > >   TPROGS_CFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
> > > -- > 2.42.0
> > >
> > >
> > 

