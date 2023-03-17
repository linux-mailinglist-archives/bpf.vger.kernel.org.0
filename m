Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9216BDE20
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 02:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjCQBWo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 21:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCQBWn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 21:22:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2B42823C
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 18:22:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ek18so14708158edb.6
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 18:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679016161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FD2v/N5eE12jm5P/MiAf+C1MY7r1gZF0qKAv5ES+TlM=;
        b=JKRLLXyx46gHwz07M91qikwbMulC+cagjQfJcrFfLiMZ+OkujbeOVxwsHyJJZ4wEEU
         6To+SoTpsdNwKIntzelyJ7jLyrWtiuq3yOtVP2ebIZ0e5do1qqs6EF8zutW7HaUo3j10
         XFMdRDlg13lmqGZ7wbhuCvVdHQet1iDz7+EFgIRyARXI1tYnbrknXj1JMjLWmC5n3am8
         iPfLFTZ0RVArRbyCkkIC+UIHluUIoF9xxwKgSUQ3mzJQEb2IuxwhyZy3dZfnypAdAGsZ
         hDOj3SIGl0IfDQvQ/fHlj9matlZlYjeBpJpMSukMzrrRrSae0I1RXcNbQAV7Ms2Ah1hX
         eZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679016161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FD2v/N5eE12jm5P/MiAf+C1MY7r1gZF0qKAv5ES+TlM=;
        b=B2yvThHN14z2QkI2mEL4hJ6pFjPELEFZ7pdGjicc+Z97AdAGd+hrzv6+9AVkqlVnld
         O+FC+fNUIB2RKcOFgU9Sivb40MC4sd8m9xA1kqMonr1ZMCVdl8mkJI7xmf+tM4/EWrTw
         D+iTmbK/30ogOlC0dXHFsc7KpyimIM/IR1CeaiHAwtdpGdcA1P079mcPp2win+nu2p1h
         GTYcrmwcyJSt/Lkp0v7RZsoaWsCaQJUL97eoQuNVfAlTAz2ixowj3npLXfEGGm8fYBjw
         /IyOHiwXnLGDfI0hslbqsCsexnIebUqdurh3eO6zqDC+WbFdGzkYOr5X4tZIuiEOhuiF
         TjQg==
X-Gm-Message-State: AO0yUKXbd67o0gjLvfNmUTiD9wnXFEBHyVhYC3JUnlVlYw9wYusTKCBq
        JLbxn1s/5i97qit9HyYTk0Qra05rgty3rN3v/alNtpQE
X-Google-Smtp-Source: AK7set8DZed6zNst0O+d1gDH9g7DI++DwZvkrkD+swjNVr4raxRffh7nKoo9PlHf6igSycSm8s1Pdp01+tuwv5jkjy8=
X-Received: by 2002:a17:906:8552:b0:8ae:9f1e:a1c5 with SMTP id
 h18-20020a170906855200b008ae9f1ea1c5mr5920262ejy.3.1679016161166; Thu, 16 Mar
 2023 18:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAAFY1_4a5MC0-BkGcRx-5n-vdXZbjjrjEukwur+n4AOXFhMHFw@mail.gmail.com>
In-Reply-To: <CAAFY1_4a5MC0-BkGcRx-5n-vdXZbjjrjEukwur+n4AOXFhMHFw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 16 Mar 2023 18:22:29 -0700
Message-ID: <CAADnVQLcqDOzXPSUUNyFE=UJHBP-ZgOEqFfaGynTUL-jQnw-=w@mail.gmail.com>
Subject: Re: bpf_timer memory utilization
To:     Chris Lai <chrlai@riotgames.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 16, 2023 at 12:18=E2=80=AFPM Chris Lai <chrlai@riotgames.com> w=
rote:
>
> Hello,
> Using BPF Hashmap with bpf_timer for each entry value and callback to
> delete the entry after 1 minute.
> Constantly creating load to insert elements onto the map, we have
> observed the following:
> -3M map capacity, 1 minute bpf_timer callback/cleanup, memory usage
> peaked around 5GB
> -16M map capacity, 1 minute bpf_timer callback/cleanup, memory usage
> peaked around 34GB
> -24M map capacity, 1 minute bpf_timer callback/cleanup, memory usage
> peaked around 55GB
> Wondering if this is expected and what is causing the huge increase in
> memory as we increase the number of elements inserted onto the map.
> Thank you.

That's not normal. Do you have a small reproducer?
