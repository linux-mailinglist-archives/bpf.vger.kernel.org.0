Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05AF698797
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 23:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjBOWAI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 17:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBOWAH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 17:00:07 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1AD7A81
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 14:00:06 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id he33so458778ejc.11
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 14:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=380gDsYjhE+NGphBQo1WtpigN1ObIXQOzsh09bs5m6s=;
        b=Nz9XzTU9DxsVVCc6B9pw95l5IMmwu9CgEdoayYdkRPgai3yQqUZYFLPTeHRXSMXwhJ
         GmVh3fGZ5kjCPxxpl2BDLOBPeoRLYVgzrcq7dHpwjBB0AAkfRGcbf11LvcAoFjw2ZDHA
         OYJxWl5xg9Tt9LgibKGFyEshdCCdpTclPUHrTjp7z/e/MjYWnyIwq5uJ5B/kMWSEAMel
         CmG95JvutqD5biDUJ4gH4qPt4OfU9bC42Tv7JX9IDVkXlMDVDtwbPofU2txddt1NpKeu
         KZg/KC/bXn7oeSJI3/qDx1HdSFx/yPiKabuhgJiT9GYU4E/Q754rMucfd0N2oQdS3e9v
         ksnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=380gDsYjhE+NGphBQo1WtpigN1ObIXQOzsh09bs5m6s=;
        b=E2B1/t8zvWtzvFDgTN608x/1/XAeQ9P/bkINr2XpYAtDfqEf0bJ5Csu3thzLMgzo+7
         nSFvsr/JPfiAabymc920m+Wxll8LKu5fI4OqSJfiwuE+vcc5a6zE88dUek0+xR55rYdt
         V1xzfMyjTjtQV9zwkT2dkFCBFUVIaB8WMpkUooHDQh3fUvN/uksSyl5vslIqEdEGXxBI
         Pmne7u6B0+itRrdl2h12cQdsPwjyX+B7j5DoXUM0ybCD6f2+k268pqZ/oiFM+m1syCva
         +NkVigvQoXxPBfN02gST5XUUJ4Lu00SuQLNMLHmWNwcOM7A8ckb+UNebJ44dDWmaRBby
         84nA==
X-Gm-Message-State: AO0yUKUZ9WM73FLnoImNkN94yvEyywKK4ww04jhi4A+AztD5LD8c8Jnz
        G1b9X19dbO/k8wUEhSqnXeQnbqYYI3F3DGu0cqA=
X-Google-Smtp-Source: AK7set8K+7Aw/ljUcgq3aeOuUdm0+2MWGIDFX/K77aqaXJK/g4+EJA9k6iTGLfEvJr8Hf6L4zstSbWgswAPXC8QyZH0=
X-Received: by 2002:a17:906:f205:b0:8af:b63:b4ba with SMTP id
 gt5-20020a170906f20500b008af0b63b4bamr1834903ejb.3.1676498405173; Wed, 15 Feb
 2023 14:00:05 -0800 (PST)
MIME-Version: 1.0
References: <20230214212809.242632-1-iii@linux.ibm.com> <20230214212809.242632-2-iii@linux.ibm.com>
 <Y+wgDzf9zjfwgFwA@google.com> <7a2d61865e0fb1ef8db5bee8f7b95b3e983e59d4.camel@linux.ibm.com>
 <Y+0Zve9/LTWaZ96a@google.com> <33d548b6b265af07b7578c529e09751b58fe92ed.camel@linux.ibm.com>
 <Y+0lhD1Um5K9Z1CG@google.com> <824f9b8fc6cc88ca5d5b1b10ebeaf0cb3c4052d4.camel@linux.ibm.com>
In-Reply-To: <824f9b8fc6cc88ca5d5b1b10ebeaf0cb3c4052d4.camel@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 15 Feb 2023 13:59:53 -0800
Message-ID: <CAADnVQKZLJdA0066f5r0Ob2vCgRs4R25p-0px1ADBE2jbsSVMQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/1] bpf: Support 64-bit pointers to kfuncs
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 15, 2023 at 1:55 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> In any case, I don't have a really strong opinion here, just explaining
> my thought process. If the consensus is to drop it, I would not mind
> dropping it at all.

I think doing:
+       desc = find_kfunc_desc(prog, func_id, offset);
+       if (!desc)
+               return -EFAULT;

would be enough to catch that verifier issue.
We have similar code in several places.
When we can print verbose() into the verifier log, we do.
In other cases we just EFAULT which is a sign that something
wrong with the verifier.
We don't use WARN in all those cases.
