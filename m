Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E9B25C88C
	for <lists+bpf@lfdr.de>; Thu,  3 Sep 2020 20:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgICSNJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Sep 2020 14:13:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41478 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726990AbgICSNJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Sep 2020 14:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599156788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yg1AqJKscV91LZKYYyZNU28u8gvJLSRmrzFmVyxeuqY=;
        b=Eg1HB62BeRXiEhN6vZgwqcTKorxMokKJSqCD8kHosrsblcjGpccoElueroEBjz15KT7ILS
        L5TaYmibCZvk1Mm976dyJLErG7Eq6afJ6WbRtuOX6G25y79huWfm25/9V48/XArvUSodDj
        3tAAr3cHusHLerRcYgk7aVXRdVTG/z4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-9Oo_tWyoOP-eicllCirvbQ-1; Thu, 03 Sep 2020 14:13:05 -0400
X-MC-Unique: 9Oo_tWyoOP-eicllCirvbQ-1
Received: by mail-wr1-f69.google.com with SMTP id a12so1366883wrg.13
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2020 11:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yg1AqJKscV91LZKYYyZNU28u8gvJLSRmrzFmVyxeuqY=;
        b=Y1HgsBjVzo+t/ToSZkbhJigcKXuTIKxRkBN4RkeJ0QqMHrjilUHkBUrOlEJzcrVUUt
         m8S3t1OduhwnDVY0WanV38GZPBSqVSIUeb/Styyo8UVlefoKUSa6kFA8jPWWcGqQH5qx
         nQ4P4XJSk37ylTSnSMiQESoMLez5eZrWE3GAR1leiUNQXhAX6zpzBbssGQmM/+MYqw/J
         f1la8sExPi2w69KevR5YVc2hKqyzWBc3loV1ZopGC9NlZAzaTiU9SkIaovV4eUdZyBzH
         J+cgNe3+JlXfD0+aeNtg6tWqDDh6ithbh4lTy8pSilOe9bU+DptjaoM4hGEFVm780HuN
         yWLg==
X-Gm-Message-State: AOAM532MmDQH2/nIL4hDM8zcYCo7qPK05KKz+c7Hfv01X+s68p+bYhyd
        SRTEcN9jIjgQzyIvOJprSf5UMz2oAAXJusY7DEBCxHHTndEfIM2QxA0vTt9VIm/3Hj3JdHh3K7e
        zoyVv9dBcddU3hN9yrDhQ80yT94Et
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr3702005wro.362.1599156784827;
        Thu, 03 Sep 2020 11:13:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsaUmQzW9WABvIoVGtIWkXt1PVBoXm1owF1RSXsLl1n8AAFIPFyH/rdK6/NBy6Jxq2VhXWV5woyAwzu8dMqkY=
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr3701992wro.362.1599156784677;
 Thu, 03 Sep 2020 11:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200903140542.156624-1-yauheni.kaliuta@redhat.com>
 <1ac6aef1-b38c-06c7-6e0d-b8459207d7d9@iogearbox.net> <CANoWswkX9xrG48HHO19Q67ogmNcOArpe4iZwWU4_S08A7H+_Cg@mail.gmail.com>
In-Reply-To: <CANoWswkX9xrG48HHO19Q67ogmNcOArpe4iZwWU4_S08A7H+_Cg@mail.gmail.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Thu, 3 Sep 2020 21:12:47 +0300
Message-ID: <CANoWswkqEnnhtmCKpjShMEFKb0mzHni498jjEjc+M4UbniBYMA@mail.gmail.com>
Subject: Re: [PATCH RFC] bpf: update current instruction on patching
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 3, 2020 at 7:13 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:

[...]
>
> I have not investigated why on s390 it is zext'ed, but on x86 not,
> it's related to the size of the register when it returns 32bit value.
> There may be a bug there as well.

Nevermind, I missed that for x86 it's for 32 bits only. So, expected.

[...]

-- 
WBR, Yauheni

