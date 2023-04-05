Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEC66D8508
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 19:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjDERkZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 13:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDERkY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 13:40:24 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9025FCF
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 10:40:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cn12so143047993edb.4
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680716420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1I1DxbaCSBTUM6UI/07mMXv2LH/gMUQvtDLXDndmsuA=;
        b=mu7RWngp5yA19n6AEHAhnSpsEORunty/vCAo9CnGLAxOUbU/RMO4lE6fwJ4/Yj30tG
         s5e/ZTkfed56S66KjbCaAgicyfMC1UEyap/h8lIydrd/NxUjv+UghpOHjgruJALtpLsL
         O01hbAh5y1n9HND5fjmWe3BOd4kLhR+hSr30dl0WjL+S5349lphAud/cyyBmzZHrETQ8
         ATmTIqFgTt5IxgJPyZJ0jT+Daby/9v9rA/fZb6Z4znrulsHpK0TLvjt8sIt6Fcox8GoB
         HDcFwGYyWLD03D/qMZJFxi2t2YrcHVoK93xzP5Az5jsSmVb9xF8tyni4vXi5g4XFZCf5
         EHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680716420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1I1DxbaCSBTUM6UI/07mMXv2LH/gMUQvtDLXDndmsuA=;
        b=fWNQtIFZxa1wo5WONy0pa5AIumtEbsSL3vhaluCuUvaJyj6WmYnNQQyeQPbyNdquXK
         afVgL/n+XN4ee9Zir6q5yAZkjX9e/C6wOTpndgFag/rcUqnQ91TUO6mkghueN//ypbpq
         u+pq2nj477jCIieGtNn/Y0neYM5WqB55tO9GcOpJAjj1vn5mJC62dSR0gPCB6JXTUepk
         B9LKrEizl+SB5Vgq+mGWJIYZ/F24MKEMsIqwDgvlxIz1XtzBwpUfRETsbCt9wAbOiylb
         YwTEvk6NyFxiIwubiV6QVzRymba56/GMxutpWvaPSSqMhsIMJAitCfG7Cj4FDJoBnVNC
         Pvkg==
X-Gm-Message-State: AAQBX9dtiN+2cltBftxy3Qvw1YSfz2RhLbEHyLxAryysUQLTHfVzViqA
        7mHcPWUQ6EWkzbdiV5qtNRS43i/CrXoVCeiVMus=
X-Google-Smtp-Source: AKy350abB6sNV89eJhXueoG2CV95k/yT/5XDD2LVaajeR8baT5dUPPTPhVX2IaO7IhUgV+nERzQwxrM8hWi37qv9D+o=
X-Received: by 2002:a17:907:2112:b0:8ab:b606:9728 with SMTP id
 qn18-20020a170907211200b008abb6069728mr2017605ejb.5.1680716419761; Wed, 05
 Apr 2023 10:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <20230404043659.2282536-13-andrii@kernel.org>
 <CAN+4W8gtHrWt_XQBTSvkMxmeuLT4hcUtYMaFRdeZfKyJ_s2QJA@mail.gmail.com>
In-Reply-To: <CAN+4W8gtHrWt_XQBTSvkMxmeuLT4hcUtYMaFRdeZfKyJ_s2QJA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Apr 2023 10:40:07 -0700
Message-ID: <CAEf4BzaKwrLhyk-Hon9Hi4aZhVrnU-OS-7-jHdd9uMzUnjRKZA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 12/19] bpf: add log_size_actual output field
 to return log contents size
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        timo@incline.eu, robin.goegge@isovalent.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 5, 2023 at 10:28=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wr=
ote:
>
> On Tue, Apr 4, 2023 at 5:37=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
> > Add output-only log_size_actual/btf_log_size_actual field to
> > BPF_PROG_LOAD and BPF_BTF_LOAD commands, respectively. It will return
> > the size of log buffer necessary to fit in all the log contents at
> > specified log_level. This is very useful for BPF loader libraries like
> > libbpf to be able to size log buffer correctly, but could be used by
> > users directly, if necessary, as well.
> >
> > This patch plumbs all this through the code, taking into account actual
> > bpf_attr size provided by user to determine if these new fields are
> > expected by users. And if they are, set them from kernel on return.
>
> Can we check that both fields are zero when entering the syscall?

Yep, it already happens and is done by generic
bpf_check_uarg_tail_zero() check in __sys_bpf.
