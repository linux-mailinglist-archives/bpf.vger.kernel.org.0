Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E853B77C6
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 20:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbhF2SYz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 14:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbhF2SYy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Jun 2021 14:24:54 -0400
Received: from mail-oi1-x263.google.com (mail-oi1-x263.google.com [IPv6:2607:f8b0:4864:20::263])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119B1C061760
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 11:22:26 -0700 (PDT)
Received: by mail-oi1-x263.google.com with SMTP id b2so24912238oiy.6
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 11:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:mime-version:references
         :in-reply-to:from:date:message-id:subject:to:cc;
        bh=ve6FtsqO3lBVtYmw4yaIh/FEI9/bA3YrbSPK3c7sYVM=;
        b=X+za4Gzqd31uE4PDFwIfWKbdA+FDvqFlGtvHhr/Z1oPtxcYy4vSDnv3AETMNqGHYDf
         cY/lrbA/YVqW807iLHxAhNo8wBLdNg5aS0/2n0PgLa6Y7FA2jNbxzewgHY1Il7tVHtJr
         3LUt0y8PQ8QQGD9XgHy0PV9Z8vfC3+ybuFIcqJGL/iZATLCDr8UpusopDIdYJ544+miU
         iJM1yzyOP69lYOfcEq3lVudqKBycIlKvxfdlh5vOOXPbxgBwksPG4DtdFED5LEyqWCIN
         DoS5qHrXhhZ+mZY5WhbqqN1I0dDu5DXwZFqVdp4X+FiwwGklJ7KX4QsYdYK0sHr5id85
         732w==
X-Gm-Message-State: AOAM5303nj0H4Nl51FRvQcBX+VPol/JOgZzdcmSYXf6upa4BkErVITzG
        h3bt+OCHG7kUOrPN8XIxLJJKiW9ZWgJO0cfyelS4OZVwKfCI4g==
X-Google-Smtp-Source: ABdhPJxIbiKK20Idx3wDVzRsBO8I+qgTywyp3VdmH2pZOAhX1A7ZP8RsW+LNGsf2ok1C7LHYZ0uE5G3S9azd
X-Received: by 2002:aca:a812:: with SMTP id r18mr125204oie.35.1624990945499;
        Tue, 29 Jun 2021 11:22:25 -0700 (PDT)
Received: from restore.menlosecurity.com ([34.202.62.188])
        by smtp-relay.gmail.com with ESMTPS id k23sm1029398oor.23.2021.06.29.11.22.24
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jun 2021 11:22:25 -0700 (PDT)
X-Relaying-Domain: menlosecurity.com
Received: from safemail-prod-02790022cr-re.menlosecurity.com (34.202.62.189)
    by restore.menlosecurity.com (34.202.62.188)
    with SMTP id f25797b0-d906-11eb-b1db-254e7df09993;
    Tue, 29 Jun 2021 18:22:25 GMT
Received: from mail-ed1-f70.google.com (209.85.208.70)
    by safemail-prod-02790022cr-re.menlosecurity.com (34.202.62.189)
    with SMTP id f25797b0-d906-11eb-b1db-254e7df09993;
    Tue, 29 Jun 2021 18:22:25 GMT
Received: by mail-ed1-f70.google.com with SMTP id ds1-20020a0564021cc1b02903956bf3b50cso3547526edb.8
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 11:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=menlosecurity.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ve6FtsqO3lBVtYmw4yaIh/FEI9/bA3YrbSPK3c7sYVM=;
        b=FNkA/mPk4pthz0vjDWsEKupp1Ceab0Xsa8JElTOKD03j7OQkUsZ6cRO5FEBRMTAppA
         WDtHkFE951YHwRAck8sEIheiAizxKadbEvGyQRk0DKuDNzbJuEwgOrdDf/9FcviSv+B1
         aAQ2pOpyrY2lackDoxUNgTpYAE/lsFZFFsSrM=
X-Received: by 2002:a17:906:9e05:: with SMTP id fp5mr23595434ejc.376.1624990941405;
        Tue, 29 Jun 2021 11:22:21 -0700 (PDT)
X-Received: by 2002:a17:906:9e05:: with SMTP id fp5mr23595423ejc.376.1624990941253;
 Tue, 29 Jun 2021 11:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+FoirAaqbnYan2NEQVaxZ2s_brPNZ02hRFhW9miyfqn+KVGbA@mail.gmail.com>
 <87wnqc1rvy.fsf@toke.dk> <CA+FoirCBPGG=dq6AO39djrrjH82-KL9HoMx=92XZXuKOLA1p=A@mail.gmail.com>
 <YNtiwhlNPgzhP3uX@kroah.com>
In-Reply-To: <YNtiwhlNPgzhP3uX@kroah.com>
From:   Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Date:   Tue, 29 Jun 2021 11:22:10 -0700
Message-ID: <CA+FoirB--QVZSPhpvbdQ_7Q5+0r_L4GT-zfOS9+s7H_vgOLcbQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] bpf: Add support for mark with bpf_fib_lookup
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ok, I'll do that.

Sorry for the confusion. My first time trying to submit a patch.
Wrangling with git to do it the right way now. Please ignore these for now.
I will submit a new one shortly.

On Tue, Jun 29, 2021 at 11:13 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 29, 2021 at 11:06:14AM -0700, Rumen Telbizov wrote:
> > Give credit to David Ahern for this patch. Shall we change anything there?
>
> Put him as the From: line like the documentation suggests for stuff like
> this.
>
> or use git send-email, it will handle it for you automatically.
>
> thanks,
>
> greg k-h
