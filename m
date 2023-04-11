Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C256DD617
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 11:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjDKJAe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 05:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDKJAd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 05:00:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53374F2
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 02:00:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5049a1085c8so1491637a12.1
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 02:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681203631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffNIN2JQQqIvfvN4iIWwGnXifObJJMjn7+pXPeTaYgs=;
        b=ECh+Lq/uyNmKNlmE80eS65tqoqpomtSCTDJ7JVz7jkaskHXqfoqY7o7IESsdW9p1Sz
         Hz67jp/tTFXYjU2aCTfXdD85dDx04nOaZ3r5f6gefsfA5GZvtDpP9BVuPKKlEn36zNyD
         uYSC35BQ2UZeu6bRRGVr5qgmZE/m3q+PeorTS3+y39VTELCeGzIOP2a6dyhjJNSHs8xG
         aIQGxT5LTUqbu5pVGQNkft3ecjJ0g0bMgLKLvhH573OmVBCsROHOMAohfHZMnsrBxhHx
         FUZ1IMo5BSENdNyTu1dInSjxHPWpHCEetIbeIb+u5qpZjsjJRM7Ag0sqVpoZh7XLXaVC
         OLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681203631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffNIN2JQQqIvfvN4iIWwGnXifObJJMjn7+pXPeTaYgs=;
        b=x89cktdGYFToocyrq6UJ7DdTLW8s2M0v0jkZeDwzfTSr8jnmbV0Juq3g6R+OytI+yw
         GmUAQ+tqQRjMuO3x62SoX9m3EIo+hMORsqR1gWMd8X11YHVx0kgzuHga1HalBAwEsIqC
         wPv89H7Gagy8zIwBRwZCxQsTYgwo1AyK3s8U3KzOUBJO+tZZu637ATuT+vnUJepMzcRa
         V0lO0zPCZfamsfeinQqdO9zhbHm/evCZEvsalHZLMrhj4RMzhA6JmC8gPvubN9tF5zTk
         GIsNhioQXnWH9fWnUf6X1fBwoRgEFV5tjMaVI0754WjyAl7Ulsp0SqNwCxgF2kOnHS4A
         AblA==
X-Gm-Message-State: AAQBX9f7CqUkACT06xVeBt36l4tNvsSt5IactU9FESqrE4C9zoH2oJTm
        Q15tqcwQEEcpy2WNj5L2JGNCI0mFFNrxntD7Lh4IeA==
X-Google-Smtp-Source: AKy350Y1EpiHnltNcvZP5c0KesdBHQQLX97V4sSbDFaZStZl+T+Psr0+W8cNnwOaAPIZKqYCl03zRuiFTleMz4oj+PQ=
X-Received: by 2002:a50:bb04:0:b0:4fb:4a9f:eb95 with SMTP id
 y4-20020a50bb04000000b004fb4a9feb95mr4609090ede.2.1681203630792; Tue, 11 Apr
 2023 02:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <20230404043659.2282536-13-andrii@kernel.org>
 <CAN+4W8gtHrWt_XQBTSvkMxmeuLT4hcUtYMaFRdeZfKyJ_s2QJA@mail.gmail.com>
 <CAEf4BzaKwrLhyk-Hon9Hi4aZhVrnU-OS-7-jHdd9uMzUnjRKZA@mail.gmail.com>
 <CAN+4W8jp=G-WaNxUaXAmwi8ofH+GxuW=7_3iMfueF+SDi9U=Nw@mail.gmail.com> <CAEf4BzZZsqo5T+S9g9ZV0QpMC_L_kagrS7vTSOMdCpb+Oe9GEg@mail.gmail.com>
In-Reply-To: <CAEf4BzZZsqo5T+S9g9ZV0QpMC_L_kagrS7vTSOMdCpb+Oe9GEg@mail.gmail.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 11 Apr 2023 10:00:19 +0100
Message-ID: <CAN+4W8j4eyk3Gb-ZjLGcSqVXE3fCR=3+3YZS1HbmioRifgA8Pw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 12/19] bpf: add log_size_actual output field
 to return log contents size
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        timo@incline.eu, robin.goegge@isovalent.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 6, 2023 at 7:35=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> ah, in that sense... What's the reasoning for this enforcement? I'm
> just afraid that it will complicate applications that don't care and
> are not aware of this field and do retries with the same attribute. On
> first try, the kernel fills out log_true_size, application retries and
> doesn't clear log_true_size (because it was written a while ago, but
> compiled against latest kernel UAPI, so passes sizeof(union bpf_attr)
> that includes new field). And that suddenly starts failing with
> -EINVAL.
>
> Seems like an unfortunate side effect, no? What's the harm in not
> validating this field, if it's an output-only parameter?

Hmm good point. Just abundance of caution, but in this case it doesn't
make sense.
