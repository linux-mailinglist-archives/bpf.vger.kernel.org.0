Return-Path: <bpf+bounces-4655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BE674E256
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E292814A6
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 23:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE635168DA;
	Mon, 10 Jul 2023 23:52:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF816422;
	Mon, 10 Jul 2023 23:52:53 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC95CA9;
	Mon, 10 Jul 2023 16:52:49 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b703c900e3so78178821fa.1;
        Mon, 10 Jul 2023 16:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689033168; x=1691625168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a48Oh9lap8k90JkfFlJ0CQL2t/AVf5j1IPeKUYcNruk=;
        b=dLW6mg/fAeH2HDDo4ghyXvvDUqKQgfKbiFAyU/i9v3TPIixY1E4YvH+4iTL84wEf4n
         AMVCCQIILkBbc7w89nPq+8Y7o1rpHWKqkyvmyIsoomQ3beeu30kuescRe7brg145YK01
         8oK9NaPxMsDKdUFbC6ObeQCvucbGXzCZFXiUIaH7n+grsqkK2yLe4GUCPyv8TxaclRK7
         y4C2xSnBuqJGicFPibucCNo9ebh2UZb/VWoi6SvT9QwqT3LrE+GkDdAnXnif4v+LU/SJ
         QN48llbJnXVHXhwRxSilF8nZ7vHcxjrWXSK6VTzOrPoDL4JLZ6S2XpFtSjVJg8lwLCUI
         i4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689033168; x=1691625168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a48Oh9lap8k90JkfFlJ0CQL2t/AVf5j1IPeKUYcNruk=;
        b=NOtE4I7cSyubG7bqtwROHKMirqattL92IRVGl5ILUGo0QBpzhnwMXW203XOB8WBEKo
         9xwIEMJqyLCPtARJySMGHandK+/mK7U2hqDaiQuffe6ERzJtc7vbckwK8XqX4mqGVSnd
         tkA/pH954uQLdsw/3UKIDgcEO9Rsy975GS1kzDcEEHEDv2TXoTK99qlLthg7yQoLbIG9
         GOyPM8Rxs/ypucZhoDqotBDut/6EhKLfRBoZ/RaQBFzjU2QgcWF3/Yg7s29xRsRjYTTA
         qwhulzzz0L0RdipDZsRxP+e43PNcye77g/g6Cd/DEZhFCpz/YtMS889c0sDVToBvgYmd
         rZ8w==
X-Gm-Message-State: ABy/qLY5wMS71CIuJGo2W3JPPc+Mp+jd4uNMa9cR21DdaJqjEfm7areT
	VwB+XwQCsnRCSeGEFjAaAOJ+Hj9diM7WtAZSGUE=
X-Google-Smtp-Source: APBJJlG6A9sggnezmiO7MOCjZS92bLzmtokuuujhOPKs8lYUkXmPn0DPcL7jBGURG/TAx+AXA9WDJ9vLFU7SQ0qU778=
X-Received: by 2002:a2e:7e12:0:b0:2b7:1b63:4657 with SMTP id
 z18-20020a2e7e12000000b002b71b634657mr4892215ljc.37.1689033167679; Mon, 10
 Jul 2023 16:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710174636.1174684-1-kuba@kernel.org>
In-Reply-To: <20230710174636.1174684-1-kuba@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Jul 2023 16:52:36 -0700
Message-ID: <CAADnVQLKJ0L1Xb5ieFo32c32NuUe89e9N_xD7hyMXUf3h8O-8g@mail.gmail.com>
Subject: Re: [PATCH net] docs: netdev: update the URL of the status page
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: "David S. Miller" <davem@davemloft.net>, Network Development <netdev@vger.kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, bpf <bpf@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 10:46=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> Move the status page from vger to the same server as mailbot.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> BPF folks, I see a mention of the status page in your FAQ, too,
> but I'm leaving it to you to update, cause I'm not sure how
> up to date that section is.

Ohh. Thanks for headsup. That part of bpf_devel_QA.rst is outdated.

Daniel,
since you wrote it back in 2017, could you update it to our new scheme?

