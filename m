Return-Path: <bpf+bounces-10767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864137AE034
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 22:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 46857B20A6A
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 20:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E30622F19;
	Mon, 25 Sep 2023 20:08:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A7322EED
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 20:08:42 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAD99B;
	Mon, 25 Sep 2023 13:08:41 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6c4e38483d2so1860490a34.1;
        Mon, 25 Sep 2023 13:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695672520; x=1696277320; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lucKNU0RDlL+gBnOBSIzkQDlaCBNbwXXxr+QvoDA/74=;
        b=lariq36/d+f/al4vHhTQbnn44OcryJfHK8thSKHlPrLFpIyU0Nc70B/A5ittPnuVhf
         iecsQ7/6Th/REP2vmJ3T85l1y6wGuLsu/n6FPQgZhY5EjIs9EsGvuTX5PM5/Q9rvimE1
         xRjxAdCNN+vISidhNnHY4WEo9PDuZErvcjUEZuTVN3cK0ayfDfPLg/fPrxHNLDq8jjhL
         QFTYsciV75f3t/I0ZS6KH9gHR1Ex7G6LwZ+iZx5JAy0QpC3jQ+obhMQQUCUrPUrv1WjN
         7Wtl1wL+YFLn/lPpQUICyoYd2tYX+t6q+1MK4O9CzHHk/Wcf5sJX+EKMtx2ykcKW5PFQ
         q3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695672520; x=1696277320;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lucKNU0RDlL+gBnOBSIzkQDlaCBNbwXXxr+QvoDA/74=;
        b=q5hj4wjTFwWjnLDVVUCKe/hNnsB3AGEja9EBaPa3I1xkr87ZQpup2wRw+OSMmNVnh7
         bLtOqFU2jK88xNbAkp8h0x6+IFnIzlv5jxkOEOf4YN6iBNltXEyNGnzjmc5TNC2YepV2
         l0TCN947Wufk4Z+yBsi1m7zxHJSb35XJahg1OdZS26g9e5RFiIYf08yZsjRvsuefrfcD
         r4JW83u5ZW0xUNqE0Marq9S1SU1aN2zEaF33EgqBxNKI984O/CY7De6yY2e7LnKTZCYE
         N2dq1L9QDcl96EWYFwMofIW2BkGNShzRAVcr9sqBJWkMksAKXxh6rTaVwdWUJAeQQPj9
         JYDg==
X-Gm-Message-State: AOJu0YysvVcn5gA49u/NL7jJfRwJ2VE+YXQkymsEM5NPXhpwR8YdoxuB
	Y4xK4pdTdak/RA0uzK/HtreHM2PI04MK1BcT8kWp9fb6
X-Google-Smtp-Source: AGHT+IE7lqvRfNQg+VrNy2nvHedN1/dcCykJg3BOdtyADFUdUiVakRQGF9UpmrugTJZV+kbYTmCjbar6IOP7e4AOlws=
X-Received: by 2002:a9d:7d87:0:b0:6b9:1af3:3307 with SMTP id
 j7-20020a9d7d87000000b006b91af33307mr8243104otn.17.1695672520323; Mon, 25 Sep
 2023 13:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5dc9:0:b0:4f0:1250:dd51 with HTTP; Mon, 25 Sep 2023
 13:08:39 -0700 (PDT)
In-Reply-To: <202309231925.D9C4917@keescook>
References: <20230922145505.4044003-1-kpsingh@kernel.org> <20230922184224.kx4jiejmtnvfrxrq@f>
 <CACYkzJ67gw6bvTzX6wx_OtxUXi6kpVT196CXV6XCN1AaGQuKAw@mail.gmail.com>
 <CAGudoHE+od5oZLVAU4z3nXCNGk6uangd+zmDEuoATmDLHeFLGQ@mail.gmail.com>
 <CAGudoHFiVLmaMbFJno47_-x3Rs2tvgXNKyNznJeCq_cF8hFVvA@mail.gmail.com> <202309231925.D9C4917@keescook>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 25 Sep 2023 22:08:39 +0200
Message-ID: <CAGudoHHm-ofzATMdE_HU2e0voKiQnkkcL+1+F73azxNeHCvYSA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Reduce overhead of LSMs with static calls
To: Kees Cook <keescook@chromium.org>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, paul@paul-moore.com, casey@schaufler-ca.com, 
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org, renauld@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/24/23, Kees Cook <keescook@chromium.org> wrote:
> That said, I've long advocated[1] for a way to explicitly disable LSMs
> without affecting operational ordering. I think it would be very nice to
> be able to boot with something like:
>
> lsm=!yama
>
> to disable Yama. Or for your case, "lsm=!tomoyo". Right now, you have to
> figure out what the lsm list is, and then create a new one with the
> LSM you want disabled removed from the list. i.e. with v6.2 and later
> check the boot log, and you'll see:
>
> LSM: initializing lsm=lockdown,capability,landlock,yama,integrity,apparmor
>
> If you wanted to boot with Yama removed, you'd then pass:
>
> 	lsm=lockdown,capability,landlock,integrity,apparmor
>
> As a boot param. But I think this is fragile since now any new LSMs will
> be by-default disabled once a sysadmin overrides the "lsm" list. Note
> that booting with "lsm.debug=1" will show even more details. See commit
> 86ef3c735ec8 ("LSM: Better reporting of actual LSMs at boot").
>
> So, if a distro has no support for an LSM but they want it _available_
> in the kernel, they should leave it built in, but remove it from the
> "lsm=" list. That's a reasonable bug to file against a distro...
>

Maybe I once more expressed myself poorly, I meant to say stock Debian
does not ship any tooling for tomoyo, but the kernel has support
compiled in.

Ultimately, after stacking got implemented, it was inevitable diestros
like Debian will enable whatever modules and expect them to not be a
problem if not configured by userspace.

I don't think any form of messing with CONFIG_LSM is a viable option,
even if you make it a boot param.

What should happen instead is that modules which are not given any
config don't get in the way.

-- 
Mateusz Guzik <mjguzik gmail.com>

