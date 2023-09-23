Return-Path: <bpf+bounces-10697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C217AC3E0
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 19:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 917F3281E50
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 17:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3A820B07;
	Sat, 23 Sep 2023 17:13:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1F3208D3
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 17:13:16 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC81AF;
	Sat, 23 Sep 2023 10:13:15 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bc9c01e154so2787487a34.0;
        Sat, 23 Sep 2023 10:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695489195; x=1696093995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNQRIBSqSG2KJPEK+9EtrBPvHIqQMKn49uSuhd1X+8Y=;
        b=Vfih4teScd9XsFon76MCctRPpChcSSoGkrXLPTucy9D7LTYG26rqI0urwsrk1XmdtF
         VOXYeDbFwAFDneVHQPvHET8/THYIW2kJvMDWK4KUv+cfYPiLAatkPMbnuZgUTNiOwhH0
         +sANsttM6RUsTmg/ND/DStmy0Tsnm+Be1Y0hyC7LKsDT1nAa1cQzvKTKOejvgTSjCJ4d
         k42ZvXPu3awOVOYX0w4YeDTKjGxfJFj/z4Z2JuxTBuEDLJSm+1OXp1FCP1iLnGMhHALW
         pURZkyueXQSOjPdfpXz0bQ+O4YhVJHz0PeK6sq+OKbr917o3G9ME5x3dXHSR36QxlSxm
         v23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695489195; x=1696093995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNQRIBSqSG2KJPEK+9EtrBPvHIqQMKn49uSuhd1X+8Y=;
        b=Id1NuMW2O4U0E/pfabYGqvK1RnTMLQ43MhtOn2b/bV3i0jHHrmHjFQCU03/wtUtg/s
         EsukC6MFqyuDldDN2k9dAYYtfy+UB/l114f3zI4TgDjFNzqN+31Ge3bELeTrFHmOxjuO
         nGYdgF30kz0wUiL7Dfru2RCsIl1TbZVKIe2CTo459CmcU6BqpiQOTfP9WfTUMZ3VnSF+
         bu3/6C7tX34LNQ6BqOal7BWxqAOXgMwmXI+o8JzfIB0uGlvneTzkCsn+aQSmUQScradB
         ay6i8BrFqJsq5jpostdeS9C88HHh2KHOdf/qVDUDr5Gg6Nw+zJchu/bpfYHUsFlwMD01
         ZDjg==
X-Gm-Message-State: AOJu0YyQ6R8MFfdLLmKMCm1F9+oEEe/fuBGWwB4qiql85p4a2ai43+Au
	yMcZ9KId83OR4EPfa5B2jsVIoRnip5epWkcbDDc=
X-Google-Smtp-Source: AGHT+IFc08gUJYv2ZD1BH52I5r5QIE/Wj3ftMOUO9crVh2goCY21a372wCbCsJbzp9PYf/2dd6Q7zuWo+pt0tK7CEmQ=
X-Received: by 2002:a05:6830:2b2b:b0:6bc:aec3:6eb1 with SMTP id
 l43-20020a0568302b2b00b006bcaec36eb1mr3929663otv.1.1695489194800; Sat, 23 Sep
 2023 10:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5dc9:0:b0:4f0:1250:dd51 with HTTP; Sat, 23 Sep 2023
 10:13:14 -0700 (PDT)
In-Reply-To: <CACYkzJ67gw6bvTzX6wx_OtxUXi6kpVT196CXV6XCN1AaGQuKAw@mail.gmail.com>
References: <20230922145505.4044003-1-kpsingh@kernel.org> <20230922184224.kx4jiejmtnvfrxrq@f>
 <CACYkzJ67gw6bvTzX6wx_OtxUXi6kpVT196CXV6XCN1AaGQuKAw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 23 Sep 2023 19:13:14 +0200
Message-ID: <CAGudoHE+od5oZLVAU4z3nXCNGk6uangd+zmDEuoATmDLHeFLGQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Reduce overhead of LSMs with static calls
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com, 
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org, renauld@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/23/23, KP Singh <kpsingh@kernel.org> wrote:
> On Fri, Sep 22, 2023 at 8:42=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
>>
>> On Fri, Sep 22, 2023 at 04:55:00PM +0200, KP Singh wrote:
>> > Since we know the address of the enabled LSM callbacks at compile time
>> > and only
>> > the order is determined at boot time, the LSM framework can allocate
>> > static
>> > calls for each of the possible LSM callbacks and these calls can be
>> > updated once
>> > the order is determined at boot.
>> >
>>
>> Any plans to further depessimize the state by not calling into these
>> modules if not configured?
>>
>> For example Debian has a milipede:
>> CONFIG_LSM=3D"landlock,lockdown,yama,loadpin,safesetid,integrity,apparmo=
r,selinux,smack,tomoyo,bpf"
>>
>> Everything is enabled (but not configured).
>
> If it's not configured, we won't generate static call slots and even
> if they are in the CONFIG_LSM (or lsm=3D) they are simply ignored.
>

Maybe there is a terminology mismatch here, so let me be more specific
with tomoyo as an example.

In debian you have:
CONFIG_SECURITY_TOMOYO=3Dy

CONFIG_LSM, as per above, includes it on the list.

At the same time debian does not ship any tooling to configure tomoyo
-- it is compiled into the kernel but not configured to enforce
anything.

On stock kernel this results in tons of calls to
tomoyo_init_request_info, which are quite expensive due to an
avoidable memset thrown in, and which always return
tomoyo_init_request_info.

Does not look like your patch whacks this problem.

--=20
Mateusz Guzik <mjguzik gmail.com>

