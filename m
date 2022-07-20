Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A5457B8EB
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 16:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240833AbiGTOwi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 10:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240484AbiGTOwh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 10:52:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7381ADAF
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 07:52:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z12so26495954wrq.7
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 07:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PUMNzOcke9F/E6l0+nSlaEl2q/BLzsi49G5O8oR/nQk=;
        b=05e5XLBmfccOHOTn5Xi23vWg8lqNJPD/R1R0dBx9OAM6rEtAjGyDb7fFMs3y3i/7oD
         /Ok5WoBVNnLuPSv+vaxNoWo7ozHczx628+bmwDooSBy4Ell7vhkiyYtko7XwBb+kbr/R
         BAjORV2J0Is7Zf5la7TDJ8tdimEtSTjqnhLmTWTo+VkhDV2SDH+8N+fLRE2KY7wZfezY
         T+8JyFzZ6P9hW/0ZmdZZ/B/Uv/FqGJI9SKb0Tf0iLP0d+exKHiujMl9frRdeNNWZHTAH
         i9rgvXBSrNV3XeYyu2mF/sA2JpA/OlBjHP/f6HQ3JwqaawYdWHZ7Uly6ofxMlSylDhlx
         Vy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PUMNzOcke9F/E6l0+nSlaEl2q/BLzsi49G5O8oR/nQk=;
        b=SdO4rLfmDjA3p6pPY6OSYAwrvkRrVx6cKrb0Vnx/ZNoN3gH1aTgS9w5S56JUwPhUPR
         NZ5OFoTMWZKo6VGzGur2s04ShWXiQfcFoFvkjnh/l5Lssf6Zo0bjT1ym0O058pwdQzUB
         i1zqa6u7XriDvI4R669EcfcTGF2Zvdkmh07naESZ1RIiY7nDEuOlqgjlZfodHzRmHmsd
         OSlWRdXZUu72/OxgNjkPtVFZs1pzhwaPP7Uopy+aSTg5rx4obai35fkR+cc+Nxg5JN1E
         kjpSrGURGCsqSZNnQ6RtC2F0wCyO/CL7IAg2LqM1af58KeDG0Br/Zs6PQv/JJcTSDayN
         579w==
X-Gm-Message-State: AJIora8GDks3HgzbvNdlhpVUZ87I+NDyTICgfsEOBIzKAiADzqVpxe1c
        dRoC+qjDygdwrJf1K9owjZlG4Dlkswyhwt1hsxIp
X-Google-Smtp-Source: AGRyM1vRgjFuWdos6HfR4YAkcb84ehTx76Uq4a7TaHyarDjXm0pNXoiIf0CYV/zUZqhGSCYFaueGHUufPPeJ3RbZVR0=
X-Received: by 2002:a5d:4f8f:0:b0:21e:4f09:9e15 with SMTP id
 d15-20020a5d4f8f000000b0021e4f099e15mr1313451wru.55.1658328754216; Wed, 20
 Jul 2022 07:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220707223228.1940249-1-fred@cloudflare.com> <20220707223228.1940249-5-fred@cloudflare.com>
 <CA+EEuAhfMrg=goGhWxVW2=i4Z7mVN4GvfzettvX8T+tFcOPKCw@mail.gmail.com>
In-Reply-To: <CA+EEuAhfMrg=goGhWxVW2=i4Z7mVN4GvfzettvX8T+tFcOPKCw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Jul 2022 10:52:23 -0400
Message-ID: <CAHC9VhSbKct_hY4UNS0oyqsov9ELxXeQc4rqpRO7AuLKfWrGDA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] selinux: Implement create_user_ns hook
To:     Karl MacMillan <karl@bigbadwolfsecurity.com>
Cc:     Frederick Lawler <fred@cloudflare.com>, andrii@kernel.org,
        ast@kernel.org, bpf@vger.kernel.org, brauner@kernel.org,
        casey@schaufler-ca.com, daniel@iogearbox.net,
        ebiederm@xmission.com, eparis@parisplace.org,
        jackmanb@chromium.org, jmorris@namei.org, john.fastabend@gmail.com,
        kafai@fb.com, kernel-team@cloudflare.com, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        revest@chromium.org, selinux@vger.kernel.org, serge@hallyn.com,
        shuah@kernel.org, songliubraving@fb.com,
        stephen.smalley.work@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 10:42 PM Karl MacMillan
<karl@bigbadwolfsecurity.com> wrote:
> On Thu, Jul 7, 2022 at 6:34 PM Frederick Lawler <fred@cloudflare.com> wro=
te:
>>
>> Unprivileged user namespace creation is an intended feature to enable
>> sandboxing, however this feature is often used to as an initial step to
>> perform a privilege escalation attack.
>>
>> This patch implements a new namespace { userns_create } access control
>> permission to restrict which domains allow or deny user namespace
>> creation. This is necessary for system administrators to quickly protect
>> their systems while waiting for vulnerability patches to be applied.
>>
>> This permission can be used in the following way:
>>
>>         allow domA_t domB_t : namespace { userns_create };
>
>
> Isn=E2=80=99t this actually domA_t domA_t : namespace . . .
>
> I got confused reading this initially trying to figure out what the secon=
d domain type would be, but looking at the code cleared that up.

Ah, good catch, thanks Karl!

--=20
paul-moore.com
