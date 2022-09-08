Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8F85B2A63
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 01:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiIHXeT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 19:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiIHXdX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 19:33:23 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D19115398;
        Thu,  8 Sep 2022 16:30:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fy31so54438ejc.6;
        Thu, 08 Sep 2022 16:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=z/dx0KeqZuxMcAhwLJfjrGl9r/xKQI+vA55XM0FUHPA=;
        b=dzLr+y291kREw5aXuDKHa83y/8ofimtNYGdsfGhNWUNsmInFNGPT4yhgD2zhYHxJFQ
         ShM9G76cR8LhS3HBJ41Fpq1rSrWetGEeR+/HKEoKay4WAqaQRBxVLjYYWeYj3isz9FZO
         4FsTkq9baHBqHlQmnIbDvmm6oY2jvOaFp60fZ3RinZFIa8VO2d5cLrTw567E6jrGjQQJ
         Sxl6L/rUnzNAv3CVjvmKoWeKIYTwg/BoTdxn2oXJunBAoMQB/FNTW6tPQhx9QI7J98gi
         ka6aHVF1QleNzXvQ4Ei78ouf26ZKs+c2V1BbTkqvdtG64I1TnG1ELEHV+V1tgAduoBMd
         JrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=z/dx0KeqZuxMcAhwLJfjrGl9r/xKQI+vA55XM0FUHPA=;
        b=k/Vclp9qlTUCVHcAk0gZrEBRmA5ABZUk+NZhO3rpewHgSZbZN7GLrvNhzSRDwHkicH
         4PqeTGMlJayLfF4XbomprZD3LyCUfF0IPIG8BXhVHxAlXmcDT0TRCdiPSa862XpwEnTm
         /FwPlljkKLiiVXaQ0z9VTJZRGdxoB70+WeXFIPoeWXn1FCDkGVI16xA9uXrozNI/LkE9
         01iCgro5X2z5tny3RKv/JcwUWG6R6s9JSlVW2+iGjWEGl1k4GqLTHGUY/mgvhYSEQQ0+
         +JUDZBZ5cJwe9iLHag/+o98pVKxto184tRoK6KDBv55RG6cX9uErW4dhVTJDinlUrmk0
         PI/A==
X-Gm-Message-State: ACgBeo2oS0k/11MuCYtPBXQlx1aVoCkW67P9PlGeMTfpW1p+euoV2Txp
        Yl0V1uYW++ntLQl1NFQcMo19UHu6AhkGLxAMD+LM81SA
X-Google-Smtp-Source: AA6agR4ekDb9bqhqwoRd3mP475enXzHpG8zDW2Rf0hzelKrLKjjzZIwc+FJSfm+sCdbfeBz1Q0uA35qyPTS8dLrlS7w=
X-Received: by 2002:a17:906:99c5:b0:73d:70c5:1a4f with SMTP id
 s5-20020a17090699c500b0073d70c51a4fmr7604921ejn.302.1662679807050; Thu, 08
 Sep 2022 16:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220829091500.24115-1-donald.hunter@gmail.com>
 <20220829091500.24115-2-donald.hunter@gmail.com> <3d08894c-b3d1-37e8-664e-48e66dc664ac@iogearbox.net>
 <m2h71k6bw8.fsf@gmail.com>
In-Reply-To: <m2h71k6bw8.fsf@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 8 Sep 2022 16:29:55 -0700
Message-ID: <CAEf4BzZ_2wCVTjhAe0XzJ5qfbVhV0pfZeJ=z9Jg_fj_fzD1JFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] Add subdir support to Documentation makefile
To:     Donald Hunter <donald.hunter@gmail.com>,
        =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 6, 2022 at 3:50 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>
> Daniel Borkmann <daniel@iogearbox.net> writes:
>
> > On 8/29/22 11:14 AM, Donald Hunter wrote:
> >> Run make in list of subdirs to build generated sources and migrate
> >> userspace-api/media to use this instead of being a special case.
> >> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> >
> > Jonathan, given this touches Documentation/Makefile, could you ACK if
> > it looks good to you? Noticed both patches don't have doc: $subj prefix,
> > but that's something we could fix up.
> >
> > Maybe one small request, would be nice to build Documentation/bpf/libbpf/
> > also with every BPF CI run to avoid breakage of program_types.csv. Donald
> > could you check if feasible? Follow-up might be ok too, but up to Andrii.
>
> Sure, I can look at what is needed for the BPF CI run.
>

Daniel (Mueller, not Borkmann), is this something that can be added to BPF CI?

> > Thanks,
> > Daniel
