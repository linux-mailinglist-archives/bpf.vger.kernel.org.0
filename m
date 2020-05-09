Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31AA1CC007
	for <lists+bpf@lfdr.de>; Sat,  9 May 2020 11:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgEIJnN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 May 2020 05:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726885AbgEIJnM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 9 May 2020 05:43:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0A4C061A0C
        for <bpf@vger.kernel.org>; Sat,  9 May 2020 02:43:10 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k1so4750549wrx.4
        for <bpf@vger.kernel.org>; Sat, 09 May 2020 02:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+dxx0bp4Evbg/9vqWOOJ7jAb64ewymHTXRZtfUF57BU=;
        b=VesQIj6oWL4G3i8h+0oV21k4qbswcdseJH9aMgCzlIh3O0776KzeS/sASlrLaDX6Nc
         07gTFCVMjwTwrRSPWh5FP7T9Lo0WxF4qEEbfhF+BANLVOdlRqRrAipqngfgreoCXX016
         kpqhEJlHHuIa+SRqEvuvrUvs6XyroxZCNZ2eVEfl+68tsjuJ6FHLxEnrZdTP4igs3xy1
         c43WSUOAbVOCtDTMW25LX1clfjI8xfj9bJVyETFwr7Eh8s4Nq8PO597asoj3DFPUX1id
         vANahAVKrXDYqImXixd90wy+kCFo7YUafQTPvT27Qq/pt8mR+R0/dDRHV0hhjR2PNs4k
         SYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+dxx0bp4Evbg/9vqWOOJ7jAb64ewymHTXRZtfUF57BU=;
        b=SKgR8zFNZNKFwOLSJ5xHISplcQep1OMlBPESfHexSV4WzUKspzjT3FZ88cgTZvxxYN
         hf2HvRHWKohW5kih06FcrrOnvZNkgu9WSahlV+AYumiLSvBxuOa/qtv0Ecg3HhjrgyXY
         9qf4U07ehOpa3xvMxjzrtkWMHjhSrfFuVYO95Fd5Jyk6aFQDVDzw75zVgRY/ja40jDhV
         OSOSayRN9JdoJg+OnWf1VcL4sm2B1T+ABuUTUdnQnL+YcZAjx6pVh9/+JI7luRsFUITQ
         YOcuUYkOhwyl3KemKQ4bFYPBtv8hu/RgmJmfYP2S1AflRTuKv2J+dhYKSuQUzlpvU/O6
         x2Fw==
X-Gm-Message-State: AGi0PuYJuUyvlJj4rnJKm+CVocN99mSbT6Cz2Q38MwTBD7HVKA9ijiTY
        uhdLsBzhPVmK3q2ZhCoz3FOISXJxD2rk0if+FaCM
X-Google-Smtp-Source: APiQypIWQSulS33xYe5WGrvReGd4GzsoT/D0U031MwIE5InNBfdp6IIrZDJPizNtXIcuqN69oLrN7XNM67wpqpZDG3Y=
X-Received: by 2002:adf:e791:: with SMTP id n17mr8234817wrm.217.1589017389194;
 Sat, 09 May 2020 02:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <3ab505db-9e04-366b-d602-6b2935739f54@intel.com>
 <CAEf4BzZXA3pDwqLGTnrDAn7cH67Ei6tp8PRZwVAmsT-nTMA0gA@mail.gmail.com>
 <CAFLU3KuU6zFs7+xQ-=vy9WEx-4U=cTSW9VXNMyxRdwY3LHc9HA@mail.gmail.com>
 <CAFLU3KuUm_1HBjyQdypuWCa4soKwXF7zEic-4=e4pvTBbuwd+A@mail.gmail.com>
 <65526c26-c94b-d5dd-7143-b1af7071dbf9@intel.com> <CAFLU3KsDXDXqqhOUTx6jij7p3tgirNtDH-619z9mvgafFYN=jA@mail.gmail.com>
In-Reply-To: <CAFLU3KsDXDXqqhOUTx6jij7p3tgirNtDH-619z9mvgafFYN=jA@mail.gmail.com>
From:   KP Singh <kpsingh@google.com>
Date:   Sat, 9 May 2020 11:42:53 +0200
Message-ID: <CAFLU3KsqJBjpk2jw90m9GVnJAJ=wqOQJX9eA14EPfuL=OSJVjA@mail.gmail.com>
Subject: Re: bprm_count and stack_mprotect error when testing BPF LSM on v5.7-rc3
To:     Ma Xinjian <max.xinjian@intel.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Also, I would appreciate it if you can share some details / steps for
reproducing this error and your environment (is it a physical machine?
VM etc?)
