Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95C12D931E
	for <lists+bpf@lfdr.de>; Mon, 14 Dec 2020 06:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392000AbgLNF5A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Dec 2020 00:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391951AbgLNF45 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Dec 2020 00:56:57 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72836C0613CF
        for <bpf@vger.kernel.org>; Sun, 13 Dec 2020 21:56:16 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id w1so16202351ejf.11
        for <bpf@vger.kernel.org>; Sun, 13 Dec 2020 21:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=7guL1PS1xkv1YoSm4j1tYIVr7nxjwyNCb2C16NvvIpw=;
        b=AVFTEXzzPzJ95+WXxcVS1dK3XLdAg7xOrpjwQi1FZtjwDCgb/I6kVfmfD82t/81ma0
         lye3pQ2VyaFnhKfd30Lf7L5VF4L3fOVGjmed3ZpaLgQGrEvEbGep2EESh3Mo3qdF3K+/
         keaOft9R4yEtXvQTXAoNfSVzDhgeLuxnxxNtH5B86HETTTIAoa2aZ/fkP3SNS7AD9Y3W
         sU2Vx4YNJdDCmxmSUAsOTAz6CZ+73K5qfTaXjeUeSpZai2icKhvlZAKHnNKLBxkrO6mp
         XWJyR//BvFjjSHqAgxlWK3xSFCbmRNGDg9gm5ifkglRS6XZxEpwAt0t51lFE4YWIbO3g
         HoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7guL1PS1xkv1YoSm4j1tYIVr7nxjwyNCb2C16NvvIpw=;
        b=uNOjo4Fr23vbohtfK+ZsmWKzXJeEQoEfQs3CYVpAf6Gd8h/zxF2dRgdC99QsLmZSJM
         T8hGjvhojNuuBTFodicNoDuu68TSsOS9qXMFMl11Bp6pVU4wX3uqN5ceFq/5+BCBOy04
         0VHmVWhguzzc2suYx5XSs7qQuRc+m+mSOnyIPNooW+26UrdTa3UEWIhM8R1Tvuwu9apz
         /10WPOLPJoAHuLEaSTUpWwswVetOFFTF9fEgGbJvdMNn2qtH7FjM4lAAAvcVRZKsTQBY
         dLuJEHXGypCweK2/ym3TD9d7zFTiKFAJSZTo/GC+kNYw74eRknF6mmMnf7ZL0ktKkkB8
         8xUA==
X-Gm-Message-State: AOAM53164PvRfE8E+mrswCOjOH9Tww6PTsFj0N5EbiDM694YLHGiR8Nx
        6XD6aC3bRGAP54EnsUZtZoGSNggU1wnBFHo+IW5tR3sDYmc=
X-Google-Smtp-Source: ABdhPJxHEoJumReKpv7Z6U5IsPF0PJNtK0oWc0ZcO3ohL2Gk2rQCH2iU/SJbaHV+nIUlIcKFFiQMJ/vJ6Us6GAZBN+Y=
X-Received: by 2002:a17:907:3e23:: with SMTP id hp35mr21442360ejc.254.1607925374783;
 Sun, 13 Dec 2020 21:56:14 -0800 (PST)
MIME-Version: 1.0
From:   Gilad Reti <gilad.reti@gmail.com>
Date:   Mon, 14 Dec 2020 07:55:39 +0200
Message-ID: <CANaYP3EH2tS=LnAoRfYsnO-zs5qaO7GuHDhw03==t+B_C8Gf2w@mail.gmail.com>
Subject: libbpf CO-RE read_user{,_str} macros
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello there,
libbpf provides BPF_CORE_READ macros for reading struct members in a
CO-RE compatible way. By default those macros reduct to the relevant
bpf_probe_read_kernel functions. As far as I could tell, there are no
variants of this macros that wrap the _user variants of the read
functions. Are there any plans to support ones?
Thanks,
Gilad Reti.
