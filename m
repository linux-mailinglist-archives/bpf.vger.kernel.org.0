Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B54014DC6C
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2020 15:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgA3OF6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jan 2020 09:05:58 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39476 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgA3OF6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jan 2020 09:05:58 -0500
Received: by mail-ed1-f66.google.com with SMTP id m13so3931749edb.6
        for <bpf@vger.kernel.org>; Thu, 30 Jan 2020 06:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=KLUUmwLfL0lJg5nXfpErbvGaGXJyUwIdXajuKEnP8mw=;
        b=nF69eL4lUe+FaC4daOF/6sydBjpN787oHOImlOKuFYw+q1Rk9VVKyNNsEsBNIW02WJ
         ftQF5AZ5l7Wnlpi0l6gFqPTmYbvVSNBpwFj+Wm/IDN06XTYKirC3PofAmvNfeiNQlMG8
         odRdTWUXm9/sHepA1i9wpDlX0kg3C1GweNP+joTXH8yY7SQ4fQwa0XsmpK+lrf+fkvJu
         N1xUKC7ORPmMoxr9qJWDTOUh6VWnAKOWVM8tUXcq1W/bg99qygiBzAqGMPYi4OfDLs7L
         omOqdfyupMJRa0Iku1kycdZXAI7sJVw03SEBnuP8sb4gsdThTOovSzisNgod55L+eLdH
         EJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=KLUUmwLfL0lJg5nXfpErbvGaGXJyUwIdXajuKEnP8mw=;
        b=OMZhVMt/k29FUeYKKiuHbZTwHaK2vAs5uDk491L5jgtuRdTAy//NRFCvROxNsi+K3i
         jOwCxkmxrAZnSHgcxKzVXl/C60bH2ND1hjKdzcPJQJXBlNZNgeamQlExlFv5f7lEspWN
         MuYJcLbvmxVOPBxTNiDy2HLkzOQdva5tPELN+x+ZBtoEJ6oeZLR/6uY2kdcdOJplQoKh
         F253dOGnwFlJUAngLVBPVayIW39zLmx27HLhuJ8/DoK91lGC2TQQrTN8MhGZ4IDg3s9U
         jPEKlP4bZvFzAOh6gdLWMnuaNBXXIZzxJ5yGbLbMCVRmHwWkZzsF4Lwao0jnbPKgNhBl
         HO+Q==
X-Gm-Message-State: APjAAAWBvY+V/vPrdIO8BTdVTf+dwcRzvXUceog8yeQLXT7tqv8jhqWO
        ONyKnZA+SmMEUSyo8QsEFaPcQ4upK4LwdrJdgKY=
X-Google-Smtp-Source: APXvYqzJfFXY0/MYIAEz2JMXzNxHVV+YLp9d31unGR8NMOV3+ZeODk/8PKrFstmpfvTwmDhZMSLB/7BSWw0VDNfqwzw=
X-Received: by 2002:a17:906:4d89:: with SMTP id s9mr4442266eju.268.1580393156602;
 Thu, 30 Jan 2020 06:05:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a50:af22:0:0:0:0:0 with HTTP; Thu, 30 Jan 2020 06:05:55
 -0800 (PST)
Reply-To: miraclegod913@gmail.com
In-Reply-To: <CAOAm71NjJWKSeKKrWB_NCvhVafVQHL-PX-YU4L4qG1wcPEKFpw@mail.gmail.com>
References: <CAOAm71MpbKSZXgiotccZuGXJVUZzVcoj_-fqzPVdOpAx+JdJKw@mail.gmail.com>
 <CAOAm71NjJWKSeKKrWB_NCvhVafVQHL-PX-YU4L4qG1wcPEKFpw@mail.gmail.com>
From:   Christy Ruth Walton <janetpenninger22@gmail.com>
Date:   Thu, 30 Jan 2020 06:05:55 -0800
Message-ID: <CAOAm71O8Xo9=oOzF=0dyV2Ta1sGzdACoW9gyKKNqK0tD7ZMscQ@mail.gmail.com>
Subject: Fwd: Hi Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Good Day,

I want to open a  Charity Foundation and  Company in your country on
your behalf  is it okay? I=E2=80=99m Christy Ruth Walton from America.
