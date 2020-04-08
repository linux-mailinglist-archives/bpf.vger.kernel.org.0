Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 601BE1A282D
	for <lists+bpf@lfdr.de>; Wed,  8 Apr 2020 19:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgDHR77 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Apr 2020 13:59:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60933 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726780AbgDHR76 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Apr 2020 13:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586368796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=QhR8/4nwZR3vI75Ff0gRFEnCsK4KP4VWpldugKNK1tM=;
        b=ixkKzvMShm0Wl5jVuKs/gF2sv+q9Q1RpuKWuT7va/9T8sp10lYoWjB4KW9bYZysLe6msjU
        jLvJfQkJmYRooO/VwQfJrYx5EDw2QbkIZ5A1ngxYtHj4fzvcebo2vWz6CIVcpxHANUD15n
        HXT8KOwCICzKRk96U4bckcN8wE4BbBs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-7OHPJOdaOz-d87rNYVgG9A-1; Wed, 08 Apr 2020 13:59:51 -0400
X-MC-Unique: 7OHPJOdaOz-d87rNYVgG9A-1
Received: by mail-lj1-f200.google.com with SMTP id v22so2063771ljh.18
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2020 10:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=QhR8/4nwZR3vI75Ff0gRFEnCsK4KP4VWpldugKNK1tM=;
        b=eQrEk/l9g1kZAYnQ63Y0u+yXfZ01NrwAyVillldyp4woHPNjyxLX5hyTTT6TYSPL5b
         Y7h9Z2U2BcxRaJea/rdhr0CNHtY35YxYePDixvVPYrV1eaGiJIeq10wMH3EapGf5J6xm
         myOBQZ7rctvDZoSn/tu72Pr3QeAoa8kLsewJ08E6z/nEYZuNgM1cKAwP2j3O5fYCU2Wh
         nkm3F7UGn8LMxlKKuMskxaS1D2Xa8uLxcC5AlU7TnwIQXlpuro4m3luzK2Mn8L0e6Den
         +S58pVyFQTzUYPUEBgWGwoE0PvdgwgA4n3pnQJdsTUoHQh3kOG8o4FTWjhJ25qGtVckK
         3nbA==
X-Gm-Message-State: AGi0Puaom2Gz+wnXywRjqtZIlOJjFOZO9gvhLst8NAZigxHHUfalDt6G
        GR5G4USqr/4BIFH4MbK5qa4w/ihNpRO6BfuLLMfXP5JpvKRQzr9XtVyedVRvCzxflcvlEW3Qp6F
        vsjWYMuOXaPaK
X-Received: by 2002:a2e:9588:: with SMTP id w8mr5482278ljh.262.1586368789139;
        Wed, 08 Apr 2020 10:59:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypKf2YsDNtmqeI+9AaCI5zrRLD+5i5vVW6uP6R3VGlXLttLLJtzSjuAu7eO2NfN5NRTn1MfsXQ==
X-Received: by 2002:a2e:9588:: with SMTP id w8mr5482267ljh.262.1586368788957;
        Wed, 08 Apr 2020 10:59:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o17sm2860424lff.70.2020.04.08.10.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 10:59:48 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 753041804E7; Wed,  8 Apr 2020 19:59:47 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Introducing xdp-project.net - an HTML-rendered version of the xdp-project planning docs
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 08 Apr 2020 19:59:47 +0200
Message-ID: <878sj57t9o.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi everyone

Just wanted to make you all aware of this web site:

https://xdp-project.net

This is the HTML-rendered version of our existing planning docs located
at https://github.com/xdp-project/xdp-project. Jesper and I are trying
to keep a rough list of all current and planned development work related
to XDP. It can be a bit difficult to just browse the github repository,
though, so we've been wanting to present the information a bit better
for a while.

Well, the above web site is just this - an automatically exported
version of the repository in an easier-to-consume format. Hopefully some
of you will find it useful. We will be updating it on an ongoing basis,
and now that we have a more-accessible version that will be an incentive
for us to work a bit more on the presentation side of this.

Feedback welcome, of course; either here or as issues or pull requests
on the github repository.

-Toke

