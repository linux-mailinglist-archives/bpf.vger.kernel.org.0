Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550575A1C68
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 00:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbiHYWbo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 18:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244430AbiHYWbn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 18:31:43 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B78EBA154
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 15:31:42 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b16so71701edd.4
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 15:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc;
        bh=oy6xBGINBua5ZrXOtFEX+0/hoeSsjJfv6Uh4rPqx6Zs=;
        b=PlibQ+6OtEIDMXRE13OEpiAJS5vXEW1raE7Zui/CaCfc7aU80puY7YEgYwxz/nUnUB
         TBGBecZd26KB6CemtueVl4JAD2mkdCT6uqwjmRCJ8mz0NZ66aYq7rMlnyLeClfgJ4AjY
         +RTZYcqQjRArxQuEOOMWNoxMPGmYdEQKr53v75vMx1Nzc7AD+QYFL5s1i2K4o5cJunuu
         VIp8IDNMDuACHiS+mb/2WVAAnqPymKiTNebbZ0f33+EcINjKPKpT+miZuKSZJax8qW+1
         yPig3vXR+hpAnh3MAwYE1oyOEF6RikzG4X2U86/nGhfi1ZkuNYmBzkdX9u//n/hBKxjn
         h5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc;
        bh=oy6xBGINBua5ZrXOtFEX+0/hoeSsjJfv6Uh4rPqx6Zs=;
        b=a5HXy70dAkdjXF77XIz6xaa5NAKozQkaZO9CGCo+Z86piLZC+weldAP/jHrItBjFze
         XbgoMe+VDf26tBeUujO6chslf72NkPIho98Ry5NtNUiJlXauhs8c5OnrHFlb4S92lm5h
         dxZZydZmN9YidTDocc0rLLeXR3cfYrG+0o/t6FV320fv+bDEEHoY8DLToAEpM1XjotsM
         Ada1G64sEfw0yFYXt97bBG9xxCXDswW7uRFvGtgAolL3Ex1NF3tK+FgvPH2Xrnb1KoeS
         6NJxUi9qPz3MQ+qNxunlbY/GcsMlMO7Gyt07j+IltdBHlK0lZATDjsDWK/YvD/R2quO3
         FEcw==
X-Gm-Message-State: ACgBeo0E3MCXhbXdbGP8yD7b3mUJAiuUVKDcksWnaAXeOdA+otUDeOtb
        ReFeFZwvX66s7yfYH9GA6D+Xp93Dcig0KnfR
X-Google-Smtp-Source: AA6agR6dsCGde5rmzNJ5lFOmwrsKLV1vLeYDIFXKpuiEhQ/8tNIfztgmhNJzN8aUuEwcPvujk77ohQ==
X-Received: by 2002:a05:6402:5106:b0:440:3693:e67b with SMTP id m6-20020a056402510600b004403693e67bmr4876861edd.226.1661466700869;
        Thu, 25 Aug 2022 15:31:40 -0700 (PDT)
Received: from [192.168.1.24] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id a9-20020aa7d749000000b0043e581c30eesm360759eds.31.2022.08.25.15.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 15:31:40 -0700 (PDT)
Message-ID: <5a14d5c9ca9782741815428f6d580b563ba7f481.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/2] bpf: propagate nullness information
 for reg to reg comparisons
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, yhs@fb.com
Date:   Fri, 26 Aug 2022 01:31:38 +0300
In-Reply-To: <630714f155a8_e1c39208a1@john.notmuch>
References: <20220822094312.175448-1-eddyz87@gmail.com>
         <20220822094312.175448-2-eddyz87@gmail.com>
         <63055fa5a080e_292a8208db@john.notmuch>
         <f040525326088f63201d2ef76a7b759f44f38350.camel@gmail.com>
         <630714f155a8_e1c39208a1@john.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi John,

> Agree it looks scary I wanted to play around with it more. I agree
> its not the same and off to investigate a few places we use
> __is_pointer_value now. Might add a few more tests while I'm at it.

I think that update to `__is_pointer_value` should probably be done
but is unrelated to this patch. And, as you mention, would require
crafting some number of test cases for NOT_INIT case :)

I'd prefer to keep the current predicate as is and reuse it at some
later point in the updated `__is_pointer_value` function.

What do you think?

Thanks,
Eduard
