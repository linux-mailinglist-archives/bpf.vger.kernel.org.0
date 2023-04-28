Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5F16F1FFA
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 23:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjD1VIu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 17:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjD1VIt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 17:08:49 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC9DE69
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 14:08:48 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b87d23729so394099b3a.0
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 14:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682716128; x=1685308128;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8ohdNYQ8/Z1H/eGlvYNDmI/V4x8gU+P97ytrPwbDvQ=;
        b=ERV2SUfnBYtS4WUMDCzvgwcFnP4YUjqPujZKD+xL3wAS8kIJGNL5ZFIB1Y7jscZSe4
         v7LXWnpVmbxNIN9KIoxR5WR5u10nD6JUtky91n6hxhoEkUVuqXd5Iln7/VkQqRN0Z8vx
         4A85x8h+Gg8M4/2H7cDO1c+xohkodn6XL8ybTD3GK0K359HBBdjddoKglMFh7HbTpp6r
         ADlwPPgE1nScMlCI8JuKzqQ1SHD4bBypnKSK6BzXs3sQQcPZeqVC5QsrHRQlPUCWM3Ra
         WIdUmZXh9gId+9BTk9X6GjRqpQUBRQjlWC4ExMZ7xiRcRoo8RpuwrWwZHv8lCgbQTLvt
         OBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682716128; x=1685308128;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+8ohdNYQ8/Z1H/eGlvYNDmI/V4x8gU+P97ytrPwbDvQ=;
        b=Psq7w9npe2Gv6EYPZ2yn+Wluo8Dml9z2w5aTPM73VGF+CeVYiMrnfK85tHQCM38a1Z
         X5OtjpoP8g6pggds6stZZBZFqNZlYt4ppjZwPUCiOphxBw+bA+20sInHIEOeHvKM96lM
         NVEeFDjvPe/uRV12x7txACMpEP4VkOX5IrU6Oh1KKrjzBhkPFRy3GmKuskJ+lf/kGZU1
         wQWfYpm3p2YR77k+knnzjOGpnlU47sqMQ53KAEGb76PZFzW9cEMSUe0y3qb1C22wjhr5
         sbl6/v+Rl+v5CSMoSCgMmeRRQxuctH7usgsqdgNfcLhgVhpLJSGI/ELL4FDBu08s564P
         Mp4g==
X-Gm-Message-State: AC+VfDyclWHdcv3b6U+FA0LmHAULsod1zbzndEYgVhUFYDGkeBuH/NbE
        ltQY3Qkrh/t2dAnlmkMrXYKLL+tcsac=
X-Google-Smtp-Source: ACHHUZ7HVGpSOc4Qw92+wGykSrKBkIHZpkW5hRYvvkVmHXb5ZpZMvJB9dwn5OLx5B8ZOE7S+6fqo5w==
X-Received: by 2002:a05:6a00:2e03:b0:63a:65a9:10db with SMTP id fc3-20020a056a002e0300b0063a65a910dbmr9633005pfb.7.1682716128013;
        Fri, 28 Apr 2023 14:08:48 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10:674d:5925:ac9a:1413])
        by smtp.gmail.com with ESMTPSA id ei28-20020a056a0080dc00b0063d24fcc2besm15591648pfb.125.2023.04.28.14.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 14:08:47 -0700 (PDT)
Date:   Fri, 28 Apr 2023 14:08:46 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Message-ID: <644c35de4b083_2c379420868@john.notmuch>
In-Reply-To: <CAEf4BzbA3DvsQgsgkWnrHUXOnFuL-doVqe2_Yo0=NQDTn5HgKQ@mail.gmail.com>
References: <20230420071414.570108-1-joannelkoong@gmail.com>
 <20230420071414.570108-2-joannelkoong@gmail.com>
 <6446dca6c74fd_389cc208e3@john.notmuch>
 <CAJnrk1aVu8Jo8LBsu8_dyVe6uFWR7BWpyQMuR-QkfT03uVie7A@mail.gmail.com>
 <CAEf4BzbA3DvsQgsgkWnrHUXOnFuL-doVqe2_Yo0=NQDTn5HgKQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/5] bpf: Add bpf_dynptr_adjust
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> On Mon, Apr 24, 2023 at 10:29=E2=80=AFPM Joanne Koong <joannelkoong@gma=
il.com> wrote:
> >
> > On Mon, Apr 24, 2023 at 12:46=E2=80=AFPM John Fastabend
> > <john.fastabend@gmail.com> wrote:
> > >
> > > Joanne Koong wrote:
> > > > Add a new kfunc
> > > >
> > > > int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start, u32=
 end);
> > > >
> > > > which adjusts the dynptr to reflect the new [start, end) interval=
.
> > > > In particular, it advances the offset of the dynptr by "start" by=
tes,
> > > > and if end is less than the size of the dynptr, then this will tr=
im the
> > > > dynptr accordingly.
> > > >
> > > > Adjusting the dynptr interval may be useful in certain situations=
.
> > > > For example, when hashing which takes in generic dynptrs, if the =
dynptr
> > > > points to a struct but only a certain memory region inside the st=
ruct
> > > > should be hashed, adjust can be used to narrow in on the
> > > > specific region to hash.
> > >
> > > Would you want to prohibit creating an empty dynptr with [start, st=
art)?
> >
> > I'm open to either :) I don't reallysee a use case for creating an
> > empty dynptr, but I think the concept of an empty dynptr might be
> > useful in general, so maybe we should let this be okay as well?
> =

> Yes, there is no need to artificially enforce a non-empty range. We
> already use pointers to zero-sized memory region in verifier (e.g.,
> Alexei's recent kfunc existence check changes). In general, empty
> range is a valid range and we should strive to have that working
> without assumptions on who and how would use that. As long as it's
> conceptually safe, we should support it.

Ack. Agree sounds good to me.=
