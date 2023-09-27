Return-Path: <bpf+bounces-10962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8BF7B0254
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 13:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id CB85F1C209D7
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 11:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3481F5F4;
	Wed, 27 Sep 2023 11:03:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785793FF5
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 11:03:36 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA840196
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 04:03:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3232be274a0so3793742f8f.1
        for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 04:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695812612; x=1696417412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KqYgYzpu9dQVwaLgGWITnIrLrn01UAiqZO4P8/APc8A=;
        b=bmpIdq07/DOLd3/bOqQ0Hk/5I0qLimy4xleCv1wsfkyCUCGy/jUv7ciBZoiZekR+XV
         B07JpjgH+oKydY6k6WhTFywCRhA0Q9weSo7XrN8frWHBoesdUI8iXT8h3x/wGqCnLZqe
         5Rc4qxWks9FmzmjfRo7xB69BZvldLNPtb4nwaAayNLO70RrwsahqDGKw+n0TrwEhN3ba
         NzzpoANWOphawuRMdx+oXzFtYPxcKmHe23ZjvH3aPHV9c9chG+6NJsCBwqaysSQwqiOG
         bakq0ucbi+3arifz66b7na4bSMYmzrI2kTIBMT3bjybgK6gQyl0GsmsK7rk6dpdva8Mr
         uVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695812612; x=1696417412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqYgYzpu9dQVwaLgGWITnIrLrn01UAiqZO4P8/APc8A=;
        b=Z4hgRrjUFLqst5VTQ1CfDhcg4jmbsiPvK3qZd+uuqKqYz7zwkcQjN7jfn8Fv/PGP4n
         vEoZmT/p9wbie9g7LdZ9V1kWcu4joCZcdbfZYKROdh57Pk7aD873djt+TUXhsN9c4dlD
         Or/rgHp8ZuY027f5Drqsmbkdz2FNG6aphIcfu6scX25UoVac2GYzrziInDIqDQuRQINA
         be9LbvK/5reH29iTsG+ACJoeG0971osuPRPHys61htEJiLuxypFEK7tjS1z0JEYxrGpB
         XfN/uAaaRbRNRAi1Z3pzRZyFfIHab6Y8mzxmYFdEyQKK0n/1920JUwNT8ldzNR1YTCzA
         mWiw==
X-Gm-Message-State: AOJu0YzVZfM3PB9rayRoNnWBskTT9cbjGqwmKdqkfk/LzgFjTTiQl7DS
	aSsXJwj/s/SkUUgID396a7w=
X-Google-Smtp-Source: AGHT+IGGdykgWRe5TgTvPyXoV1+HPd2tT2h+/9goRCJnUEr+nOVrmxxJnxmq7rUy+GvF3vaMZEd5iA==
X-Received: by 2002:adf:fccd:0:b0:317:dd94:d38b with SMTP id f13-20020adffccd000000b00317dd94d38bmr5006015wrs.10.1695812611812;
        Wed, 27 Sep 2023 04:03:31 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcc88000000b003fbe4cecc3bsm12490917wma.16.2023.09.27.04.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 04:03:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 27 Sep 2023 13:03:29 +0200
To: ruowenq2@illinois.edu
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, jinghao7@illinois.edu, keescook@chromium.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Jinghao Jia <jinghao@linux.ibm.com>
Subject: Re: [PATCH bpf-next v3 1/1] samples/bpf: Add -fsanitize=bounds to
 userspace programs
Message-ID: <ZRQMASduySxE+TO2@krava>
References: <20230927045030.224548-1-ruowenq2@illinois.edu>
 <20230927045030.224548-2-ruowenq2@illinois.edu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927045030.224548-2-ruowenq2@illinois.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 11:50:30PM -0500, ruowenq2@illinois.edu wrote:
> From: Ruowen Qin <ruowenq2@illinois.edu>
> 
> The sanitizer flag, which is supported by both clang and gcc, would make
> it easier to debug array index out-of-bounds problems in these programs.
> 
> Make the Makfile smarter to detect ubsan support from the compiler and
> add the '-fsanitize=bounds' accordingly.
> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
> Signed-off-by: Ruowen Qin <ruowenq2@illinois.edu>
> ---
>  samples/bpf/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 6c707ebcebb9..90af76fa9dd8 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -169,6 +169,9 @@ endif
>  TPROGS_CFLAGS += -Wall -O2
>  TPROGS_CFLAGS += -Wmissing-prototypes
>  TPROGS_CFLAGS += -Wstrict-prototypes
> +TPROGS_CFLAGS += $(call try-run,\
> +	printf "int main() { return 0; }" |\
> +	$(CC) -Werror -fsanitize=bounds -x c - -o "$$TMP",-fsanitize=bounds,)

I haven't checked deeply, but could we use just cc-option? looks simpler

TPROGS_CFLAGS += $(call cc-option, -fsanitize=bounds)

jirka

>  
>  TPROGS_CFLAGS += -I$(objtree)/usr/include
>  TPROGS_CFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
> -- 
> 2.42.0
> 
> 

