Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B437340994D
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 18:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbhIMQeR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 12:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbhIMQeI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Sep 2021 12:34:08 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECACC061574
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 09:32:52 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so6994026pjc.3
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 09:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U1S56xap7rMoL6IIAqj7ZyI9LDQKUSg5KNcDFqwFjuI=;
        b=jkUw7xAqeBx2DrTcsZeselAIfNZpDjGsi6lAMyJfI/mRhDVrdWPZO0cT7VQNEmt6Yb
         5J4AujVs2x5sl6nKf50Ev+8vOdKYcTBYg34aQ6fJBxlsiDGEjaCOkwYcFg0tOostFPRh
         n4VKVVzrs7ApDL8meDVZ6gX0h27/+r3CXUbNUibciPkh5Bd5jSQ5SZ6gK2Ys0iuvfu0T
         8VNuIJjOye7HXhZxwPC9Vr4LI8ftjanksCnjhbPOTkkpzELCeYulqiTbDHwkyR8UKmzv
         up+kw/IId96ssXU8yKpdZs0Z2kw1eFmwTENH7JVi2Pw119i9HwI8MC5Q+iZVvIACuTUa
         FoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U1S56xap7rMoL6IIAqj7ZyI9LDQKUSg5KNcDFqwFjuI=;
        b=hSyDNBafJPvv3xSRPyJIXrDkgs18egWr7HNsg8g+GS6IIRhZw5mE82ejKy7orsrOQe
         BSJKSJ0gGainmxYhYbYFY0Ngwl7v1EVxd3zdVYekEaeBu6M2f5MUiHLLJMow3XUDP9zM
         W1QOzX2BQ+Dcv4L4e6VAtfgHW4CIucuWySPnZha9STGmhuLnpEBfGl2bMSEGB54rQUgt
         P8aPiYTbisWKOaflQSwCeB+FZg4/NT+1CJSc3EnVgQTKo8TWycm4xDze/HgFPHdNnW4h
         +HZfetxwvzTXDeqScV5t+MgdRUrBf7zf5Mjq0q7cGiPowYmgJsT/uu3bgWzY0vmoGzHr
         pE1Q==
X-Gm-Message-State: AOAM531wrR4Xnfyy8yZi+azRWD2WRmYTKXPB3JhY4CWmJSuHkA8PZvpf
        irHrBWVhd2DS1+w+dOt1KhYT1dCBwhE9eZ05WN7wMTe9
X-Google-Smtp-Source: ABdhPJxEVzSQGX/NrOfxbFPpOW3TWGQPZ5+ORSbMLRrdX2u9tI+NRO7xgR6AHBAESh5cRuVEuHNADiVjdPug24y2PRo=
X-Received: by 2002:a17:903:32c6:b0:13b:9cd4:908d with SMTP id
 i6-20020a17090332c600b0013b9cd4908dmr2748287plr.20.1631550771927; Mon, 13 Sep
 2021 09:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <93b37b05-3aab-3e50-bd1b-e97a8d5776f2@gmail.com>
 <34d3b670-d49d-c432-892e-c86954cfd761@fb.com> <54b7d530-7a6b-8780-cefd-8e4227b10204@gmail.com>
In-Reply-To: <54b7d530-7a6b-8780-cefd-8e4227b10204@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 13 Sep 2021 09:32:41 -0700
Message-ID: <CAADnVQLPvPCd3yqSDiL4QV=OfJrH-DUsD2FzPa3uyaDgXyJurg@mail.gmail.com>
Subject: Re: Why does tail call only unwind the current stack frame instead of
 resetting the current stack?
To:     Hsuan-Chi Kuo <hsuanchikuo@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 12, 2021 at 10:08 PM Hsuan-Chi Kuo <hsuanchikuo@gmail.com> wrote:
>
> No, I didn't hit this limit.
>
> The current implementation already keeps tracks of the number of tail
> calls which to me is the same effort of tracking the stack size. I was
> just wondering if there's any fundamental reason that you can't reset
> the stack directly. But it seems that there is not.

The tail_call unwinds the current stack frame.
See comment at line 3585 for details.

And please don't top post.
