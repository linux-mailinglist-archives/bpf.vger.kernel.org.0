Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30B06D86D8
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 21:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjDET1g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 15:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDET1f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 15:27:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC734EFF
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 12:27:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94771f05e20so65803766b.1
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680722840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YKUi+6U31NWDl/h+zd8ELO7SVaeoFAksVrDxS1TyObI=;
        b=htMzbCx9nAgMwyR2yAtuRvfOIyKC4VN7Q0TiHrLMfwJj/bAnl6DpdsPh9tbfrKLpU5
         soSfe0cRLo79AwBDWcnJpSCFRF77fEztAQTfU1vd2izkgvhCAMVYhs1bmjqgIdW+nId5
         UeEPrL5LuMCZa0HmJqY44GNZgX47DwYhpqExQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680722840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKUi+6U31NWDl/h+zd8ELO7SVaeoFAksVrDxS1TyObI=;
        b=w/imTIW6ALoSBKylyik21vEsoW/vE2+5phe968Ny7BWi5lA4DdZa/mOCI8bbqWbifT
         aa0n1mAH3XERphMTyNnU6zKnX1ZZXvX6ElF7ctDz05IzH+N8+SS0oT//cuk+aJ2KZs+B
         8yDu3rBi3SUxKLDayBdjLpQ4TOHFvMv5Yq6YYkIDt2+1bi/tW1M/Dv3Bz3n+r3AjQJ6w
         9oxDr9IQKR++mY+BVFviKh0r4f3ChVMwmLL8mcyrysvupl1KKq26TbKHW4EG9+93qFJv
         tgEnbzEF8TxSq55o6O1ZDgoiekdgFl501u10fJQ/UtZS216olLXEqns98jPCnOL+riAC
         71Fg==
X-Gm-Message-State: AAQBX9cUtbOq3HkEjk6Uz99MSfUFviDp/9Ikynr3rmCJ5dKekGvDj9tC
        fs4QiGeIIkJJMDTBH7TX4MCUGyDWsD0fbpMMs7XLh2CS3MjlY9oKDuk=
X-Google-Smtp-Source: AKy350ZHbkMIltRN+83h/42CNtWHk1qgcCeOXN0WyGcCXMcdodPfRJOeSrPwuLOkX0/Q5UYoVmN1OTjHAtD6C19pyBE=
X-Received: by 2002:a50:874f:0:b0:4fb:e0e8:5140 with SMTP id
 15-20020a50874f000000b004fbe0e85140mr1700321edv.6.1680722839818; Wed, 05 Apr
 2023 12:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230403145047.33065-1-kal.conley@dectris.com> <00f36cce-f186-2d39-ae5c-67da3f43129b@linux.dev>
In-Reply-To: <00f36cce-f186-2d39-ae5c-67da3f43129b@linux.dev>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Wed, 5 Apr 2023 21:31:59 +0200
Message-ID: <CAHApi-k9G6o_Xf9piDKRPLGTMa+CD-1F2-aDqth-dz0_yoYZfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] selftests: xsk: Add test case for packets at
 end of UMEM
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Magnus Karlsson <magnus.karlsson@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> I tried test_xsk.sh. The changed subtest runs ok, so applied.
>
> I got failures from test_xsk.sh (even before this set) though. Are these
> expected or something missing in the environment like kconfig?

I fixed the other errors here and here (please apply those):
https://patchwork.kernel.org/project/netdevbpf/patch/20230403120400.31018-1-kal.conley@dectris.com/
https://patchwork.kernel.org/project/netdevbpf/patch/20230405082905.6303-1-kal.conley@dectris.com/

One is against bpf and one is against bpf-next (because someone told
me to move it). I guess they should both be applied to the same
branch, probably bpf?
