Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB8A1B485C
	for <lists+bpf@lfdr.de>; Wed, 22 Apr 2020 17:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgDVPSX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Apr 2020 11:18:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41749 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725924AbgDVPSX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Apr 2020 11:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587568702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6U0ygyZCylOphk+l41MqJ32sU6o7YOz1pFlkn9W0s1Y=;
        b=D3PzfED3Rvq/KauPRuzrx/zy7J1eNHZHj34WYlzUlPfF7Yh9WOzZwJ22dYK6+++u2CF2eO
        FsvYtnv8relBI2NXuddd6Pv7gVH7P4w1WfK0wP6iENjPRbodfKHiOZjq2fez1gb0oyzEfU
        Co5HtXObVh7Xf3eW5W6isFlzFE017ws=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-HfPLtRvmN7GezuaXlBfgpw-1; Wed, 22 Apr 2020 11:18:17 -0400
X-MC-Unique: HfPLtRvmN7GezuaXlBfgpw-1
Received: by mail-lf1-f69.google.com with SMTP id l5so1042951lfg.3
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2020 08:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6U0ygyZCylOphk+l41MqJ32sU6o7YOz1pFlkn9W0s1Y=;
        b=dPqUbx31hw5esTRLTybBQepFFi0t1dIrHDfNcpqcjJwa5TzQa2qQZWZqztr7vn9H5D
         5ZYERMRPOWHwWaVDntPQp/Nupynxr2Omw4Hj7hdMKLYrWWxaB95AmXWtBa8zcVwShDbF
         7iuHJNXQkIJcGBvQpQWKJ+4R6+z/l+qrPZFZ3d2ft+2Hx5/400yxmcxqR0Jgzk3Li+YI
         z/P7MqWqLTY3wJXKI1yFcUDwB0atjHGUlqUgwa4Z2lwYGiSsOv+c6DjCTJVKh91+Kl5w
         Twv4aiJFxiiUZmi8lN8XOV2voTxhP5+fYMJl+rs5fUtFDJt09sEyMzFTrqMLQjHrIoGb
         KRdg==
X-Gm-Message-State: AGi0PuYSyT/pEvTgb07RIh5XtEU5OIcbZZpqDyI4aeHXTqgBT+fG9Xqx
        AHw2kTEwp2B8TDQclqGTEnOSrDEOC8xUImlfekpvX+eb0KaEF1yyWJBkURKjDLhfmBqUfxT0XKu
        Kf8ZJ5So16MgE
X-Received: by 2002:a19:ee11:: with SMTP id g17mr17209742lfb.42.1587568695694;
        Wed, 22 Apr 2020 08:18:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypKRbXAybKZjkvQOI5aPGzVdgAfFvM2w6ipXmRyeXI+sY7t4e2XoU5XebYXxzzSK581tc84Bpg==
X-Received: by 2002:a19:ee11:: with SMTP id g17mr17209731lfb.42.1587568695470;
        Wed, 22 Apr 2020 08:18:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id x21sm4355883ljm.74.2020.04.22.08.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 08:18:14 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BAD331814FF; Wed, 22 Apr 2020 17:18:12 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Christian Deacon <gamemann@gflclan.com>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Bpfilter Development
In-Reply-To: <abc35979-c44e-da12-e891-5409f587cee9@gflclan.com>
References: <ac739c9c-f377-129f-1d4b-6c4c7e15f83d@gflclan.com> <871roh9jsu.fsf@toke.dk> <abc35979-c44e-da12-e891-5409f587cee9@gflclan.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 22 Apr 2020 17:18:12 +0200
Message-ID: <877dy78s7f.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Christian Deacon <gamemann@gflclan.com> writes:

> Hey Toke,
>
>
> Thank you for your response!
>
>
> Regarding the ETA rule, I will keep that noted in the future.
>
>
> Thank you for the information regarding Bpfilter as well. It appears the 
> development towards this has stopped at least temporarily. We will be 
> looking into using XDP-native in this case! I will also take a look at 
> the XDP-filter project you linked to see how everything is done, etc.
>
>
> Thanks again!

Cool. You're welcome :)

-Toke

