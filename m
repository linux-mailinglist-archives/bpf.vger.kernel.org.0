Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC73B1692
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2019 01:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfILXIm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Sep 2019 19:08:42 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:33133 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfILXIm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Sep 2019 19:08:42 -0400
Received: by mail-lf1-f52.google.com with SMTP id d10so20676099lfi.0
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2019 16:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/5S16DQfAjuE8QsLW9bADwc/2fkAheU+o57IlmqMXU=;
        b=Aa2qs56FD27COHBL9ZSpQaQJYhDIYsnARFP0xT/dRqoZBEf/8DTZZnRv4sb1J0INcm
         YPzoNk4AYGGr6cEk18ypJqofDrQ6GrvbDVmWVwsgBrvFuxHb4jc1Uavvtlv7JJtR8EfP
         N603n4Q+hiXmC9r5buErTxezIa5ALED0Z2zDuZTr7KAlR3goNl7VXD8oaDKWqab6IHMm
         CGU0KziWHnHPCara4HXYAWDlLt6wrQbxWUyUQo3XqTJ6//OKZzKsUtWs4zsbaeiXotL1
         iSmpntu7VxFVR+fd4rVzwAFjdQbTTW5hqLb9dlw2RsERmLfUCUALwHBIJNAFyjuE4tai
         JX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/5S16DQfAjuE8QsLW9bADwc/2fkAheU+o57IlmqMXU=;
        b=jiIMfH0D0BB0dLnQGC8XI6+m5H/JHJaKbpZv0scoZDLSLfdHSHljkVKe0rkm+eh2NI
         cJzU2TUe71KESSg2oy2OxNEmdU0mKuSrMMycA2g69d9Xg8esR6LC28ysdyBJNYQnHBlL
         HVYr61jMKZi5hbu78dPgW1uCZ/vRpB9FyvSo/zCiErQksY9qOIIpVmBOr+5QxvoFV9yr
         Oslbr/aO6stNjNWeFQ/5JvAxadt74DyJf57PZiWz5RIuOh2Cbv5frUfRukmEUQ8QppwY
         nAhj8lxrcsase83p40x7ImK0uf/iZ7PpKbjdvmjf6HCgcLSBiLy1yMts+qWK3QGzhMSO
         c6WQ==
X-Gm-Message-State: APjAAAU0ro/trmkNSR1utxiDE5fvbjDDWcBzV4rzvEfRMXjDNlCQyBTU
        /igpViEp/iyd7M9HHzMfQSv2r49hZU5ZDCx7LHg=
X-Google-Smtp-Source: APXvYqze2NL5huvrL8A3vpVxR9TL7RGbcUjyWxyLajXmPs114WhhSYek75OjWPaiRF/HKwAMhgi+btiy35RVU8uzUhc=
X-Received: by 2002:a19:3805:: with SMTP id f5mr6852966lfa.173.1568329719938;
 Thu, 12 Sep 2019 16:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72kQUvnVq0U-okpND8L5xueHs4o3-mKMNX8_P0n5uZw+-w@mail.gmail.com>
 <b5cd34b624f07ed136178724f208f027644f36a5.camel@perches.com>
In-Reply-To: <b5cd34b624f07ed136178724f208f027644f36a5.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 13 Sep 2019 01:08:28 +0200
Message-ID: <CANiq72kzc3wn1Xm3Ndpt1V-HLsRJ0sGph4+YgByBfdLjjfNCTQ@mail.gmail.com>
Subject: Re: Strange scripts/get_maintainer.pl output
To:     Joe Perches <joe@perches.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 13, 2019 at 12:51 AM Joe Perches <joe@perches.com> wrote:
>
> This K: entry matches a _lot_ of files that contain bpf.
>
> For instance, the .clang-format file has:

Aaaaah! I thought the matching was not using the contents of the
files, but the commit information etc.!

Never mind then -- thanks a lot!

Cheers,
Miguel
