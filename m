Return-Path: <bpf+bounces-10698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDC67AC3E4
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 19:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8F5F7281E47
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 17:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D2920B24;
	Sat, 23 Sep 2023 17:15:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC7B18E15
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 17:15:08 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39201B3;
	Sat, 23 Sep 2023 10:15:06 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6c0f4ad9eb1so2524386a34.1;
        Sat, 23 Sep 2023 10:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695489306; x=1696094106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3EL2LNx3IwGXpmpf0aHodFz8cWHTJEiO22wLLKNkAg=;
        b=Zbhcknprlr1/T053mm9KDPNNkcKFp3+Wh8cWWjkE8FjcXBDXsyIubDrLJ0C2k3Z6Xh
         Rl397KvVKilKDP5Ux/x4GXFiuyR5uGee4mGBrj+4ue8jtvOwlKu++Xl4+HsWk+F2q7hY
         3iDw/9Lvl2Sg5oxKvlQmCGq0GE2rLw7GP3dWmOvhcwHI+5XIyQuP/kqsvVfCScGaOo+8
         B62DA09qkBdBBuEaSbvy6hw/wl3YgzKbU38UsHaRKZHb/j9RuvAyvIBITXhZZDHeAKld
         VGAPIWuPre8+2DFZnxVUv9/Be2oytIwsPsPEW4+rF1MySjAiPdL54PLx38A2S6XAqr8a
         vioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695489306; x=1696094106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3EL2LNx3IwGXpmpf0aHodFz8cWHTJEiO22wLLKNkAg=;
        b=nURoTdCCuMGD18oivqVxqDFjWgfoEE17UpYUAOjzruizZCnk8vXNEHC0lKCdioJLXu
         ghw98YGme6lDwFZhDBDrTkn8gCgJV8ypM14GdmF77++5uAt6JdK4efsQd7xKbKI5vMNP
         t+nCn4kFYyrAMVYYl2azz12xG3V5rQ9PQazcnVCNjyPA8vmGv49Ud4dXbp3zfw9D4dzf
         xuNerEnC82SZ0pscF0dX7nmZc7yDhdU5QOoDqgxXwva0IZg0aBhpCDuBuGuPODgQFnQX
         KcszrXiFoKwHGnPrcKpm6RFF2Kn+qPyZCjmUi/OnKkPGoG6775/VqQpUZYiN8HyVPFiM
         V/eQ==
X-Gm-Message-State: AOJu0YwWcNqXR9rStRvdDDRLcBHxdPCchUMwOC0zxk1K3SS8cNIvo/IO
	kji57zi+wCQsO8TgjYyYhR8HXABPsgBNygDrcwI=
X-Google-Smtp-Source: AGHT+IFhI6XZWNUCSPGO3a2pZHyGY8wuQeR+jrMQbt440aLIyHlBRzDA2RRORXck+8za79qPalrtYIUjtX3FaDt9p14=
X-Received: by 2002:a05:6830:20c8:b0:6b9:146a:f1c9 with SMTP id
 z8-20020a05683020c800b006b9146af1c9mr2983657otq.0.1695489305947; Sat, 23 Sep
 2023 10:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5dc9:0:b0:4f0:1250:dd51 with HTTP; Sat, 23 Sep 2023
 10:15:05 -0700 (PDT)
In-Reply-To: <CAGudoHE+od5oZLVAU4z3nXCNGk6uangd+zmDEuoATmDLHeFLGQ@mail.gmail.com>
References: <20230922145505.4044003-1-kpsingh@kernel.org> <20230922184224.kx4jiejmtnvfrxrq@f>
 <CACYkzJ67gw6bvTzX6wx_OtxUXi6kpVT196CXV6XCN1AaGQuKAw@mail.gmail.com> <CAGudoHE+od5oZLVAU4z3nXCNGk6uangd+zmDEuoATmDLHeFLGQ@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 23 Sep 2023 19:15:05 +0200
Message-ID: <CAGudoHFiVLmaMbFJno47_-x3Rs2tvgXNKyNznJeCq_cF8hFVvA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Reduce overhead of LSMs with static calls
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com, 
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org, renauld@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/23/23, Mateusz Guzik <mjguzik@gmail.com> wrote:
> On 9/23/23, KP Singh <kpsingh@kernel.org> wrote:
>> On Fri, Sep 22, 2023 at 8:42=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com=
> wrote:
>>>
>>> On Fri, Sep 22, 2023 at 04:55:00PM +0200, KP Singh wrote:
>>> > Since we know the address of the enabled LSM callbacks at compile tim=
e
>>> > and only
>>> > the order is determined at boot time, the LSM framework can allocate
>>> > static
>>> > calls for each of the possible LSM callbacks and these calls can be
>>> > updated once
>>> > the order is determined at boot.
>>> >
>>>
>>> Any plans to further depessimize the state by not calling into these
>>> modules if not configured?
>>>
>>> For example Debian has a milipede:
>>> CONFIG_LSM=3D"landlock,lockdown,yama,loadpin,safesetid,integrity,apparm=
or,selinux,smack,tomoyo,bpf"
>>>
>>> Everything is enabled (but not configured).
>>
>> If it's not configured, we won't generate static call slots and even
>> if they are in the CONFIG_LSM (or lsm=3D) they are simply ignored.
>>
>
> Maybe there is a terminology mismatch here, so let me be more specific
> with tomoyo as an example.
>
> In debian you have:
> CONFIG_SECURITY_TOMOYO=3Dy
>
> CONFIG_LSM, as per above, includes it on the list.
>
> At the same time debian does not ship any tooling to configure tomoyo
> -- it is compiled into the kernel but not configured to enforce
> anything.
>
> On stock kernel this results in tons of calls to
> tomoyo_init_request_info, which are quite expensive due to an
> avoidable memset thrown in, and which always return
> tomoyo_init_request_info.
>

Erm, which always return TOMOYO_CONFIG_DISABLED.

> Does not look like your patch whacks this problem.
>

So I am asking if there are plans to make these modules get out of the
way if they have nothing to do, like tomoyo in the example above.

Of course preferably distros would not make these weird configs, but I
suspect this ship has sailed.

--=20
Mateusz Guzik <mjguzik gmail.com>

