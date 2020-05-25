Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8791E0C71
	for <lists+bpf@lfdr.de>; Mon, 25 May 2020 13:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390003AbgEYLGP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 May 2020 07:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389897AbgEYLGP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 May 2020 07:06:15 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3753CC061A0E
        for <bpf@vger.kernel.org>; Mon, 25 May 2020 04:06:15 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x18so6270627pll.6
        for <bpf@vger.kernel.org>; Mon, 25 May 2020 04:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QcB2YOMl1yui9BYd9Im0D0BSfvlNUCbYy9AD2DvaL7w=;
        b=CSD6a6sufHaZhkOBv9yKYCjMCC+YfHlcHQ+zV16z/tnX1WZhRGlK2aXjADa2LchTOA
         hOyw6uLnjSabILRR52IJm8yt8qJ43zhdaGgeMeN8wxODr2Kpn8CLJ6JulYu8bRZCWYQW
         4qQjvVwInFqFK4WF/wQQkNZpTxc27SH3Y+vwdEvmPgsXJHQEibkdiE9rqhX7Ty2iYHIT
         /L7n1sWJ7n8FkDW7qWj0AWtWcwp3+PRvvDCc8pclYtyyy4zCFTJT3w5reDhk1lxQVPzP
         KvViNl8uOnRYczcFW7SIYVL/6vXyA7AD5QFJThtiOD2/1NOpdZgnv4uHpGO1tlZ7ikg4
         iOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=QcB2YOMl1yui9BYd9Im0D0BSfvlNUCbYy9AD2DvaL7w=;
        b=W58fjWecluNz8H8Qea2xwc1qRITGQcQ2BYJBIepp5X0Rcz9zEgsn3dw7Xx8HfMQyQN
         1fMcchpxohMq9NkO4IgUE/2WTMaPOrp6fci042BvKqIhXk0n3mPPfI7tsSyAU0Wer97s
         DpyzquDh8vGPE/pHg5PY/To44geEIxXmCfifGUVBXrNhZP7CMNl+2zDEKuRYJluqd0+I
         5/N6pafA86bX91AcX/NAFBcjWB5PZuQ2WC3ekpTwzNteZXZP9aplbdmANOqUTN7S65sH
         3DvM4LN7E1iRlJTsPsb+IzKxkmsYzoXIXhq4F+bRjytlSXcq7FUuJmB7lfc6vJHnUbkg
         4Z8A==
X-Gm-Message-State: AOAM532Eqv6gvExoJqLHlCW2r2BP7IRL0CYBqy1G8NMz0B3L9r2R2wZY
        oysXYpy7d+KTds1+wWBOPpH7f4/5N27pBEZj18U=
X-Google-Smtp-Source: ABdhPJysSopkFhyvmH1+4sFFCOSLxRl7E6LiRtzcwS+hV0NJHoLPz+EgTXl3IWQkXL/2u0CLZC/ZsM2h+FEd311Z6yI=
X-Received: by 2002:a17:90b:80f:: with SMTP id bk15mr20557933pjb.51.1590404774824;
 Mon, 25 May 2020 04:06:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:36c6:0:0:0:0 with HTTP; Mon, 25 May 2020 04:06:14
 -0700 (PDT)
Reply-To: farmer2006@embarqmail.com
From:   Mary Farmer <orabank751@gmail.com>
Date:   Mon, 25 May 2020 13:06:14 +0200
Message-ID: <CAB9NweQ63C8npBLM1-3zpp_e=+fofJKXLXEhXfe2LcHmXCDEeQ@mail.gmail.com>
Subject: Dringend bitte lesen
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--=20
Lieber Freund,

Es gibt etwas sehr Wichtiges, das ich mit Ihnen besprechen muss.

 Ich schreibe diesen Brief in Tr=C3=A4nen und Angst. In Tr=C3=A4nen, weil i=
ch
Ich werde bald abreisen und Angst haben, weil ich nicht wirklich wei=C3=9F,=
 ob du
werde dies treu tun.

Ich bin COVID-19-Patient und der Arzt hat bereits best=C3=A4tigt, dass ich =
es kann
nicht f=C3=BCr die n=C3=A4chsten 7 Tage dauern.

Ich habe einen betr=C3=A4chtlichen Geldbetrag in einem Sicherheitstresor hi=
nterlegt
in deinem Land. Es ist in Kofferr=C3=A4umen und sobald ich erhalte
Ihre Antwort und sehen Sie Ihre Bereitschaft, das Geld zu fordern
Ich werde sofort die ben=C3=B6tigten Unterlagen und den Kontakt weiterleite=
n
des Sicherheitsgew=C3=B6lbes, in dem die Sendung deponiert ist,
Ich bitte Sie nicht, mir etwas zu geben, aber ich m=C3=B6chte, dass Sie hel=
fen
Menschen, die mit 60% von diesem t=C3=B6dlichen Virus infiziert wurden
Das Geld und 40% sollten f=C3=BCr Sie und Ihre Familie sein.

Ich werde den genauen Betrag in den Feldern offenlegen, sobald ich
Erhalten Sie Ihre Antwort.

Gr=C3=BC=C3=9Fe.
