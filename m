Return-Path: <bpf+bounces-55462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AADA80DC1
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 16:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331183BF4D4
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 14:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F031DE883;
	Tue,  8 Apr 2025 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqhxqQHS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549231D63C4
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744121942; cv=none; b=d6qO3+JZFkFDrCJE1TBDRsQ4c8jRMdugSwdqXyyTX2SsMZiSYc8dYJv/qnnTQjbT5JBBY8vCAsYBJaogeiMQhbFSZERaEl8F4tqhwc9DSptMELEEHbHSuiOEtAi84VMfqOac6AdjrPx+0ryLhI/1IC+rlhC/16kEcpgXiyu2znI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744121942; c=relaxed/simple;
	bh=LU9c6S8jykeOIbG6spfGjk1g+WXwLSV3Y9u1UsLCvIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXhR7ZbzDkr7CmxJXXjXnO9f+/ms1MWzxV4ZH0KsQ8OpW9pcHI1W6UrFR0/GY85eB2p4rIz0/NkzJU55ljj9fP0WrIctffSudXz44HrP5JZvjTXUEXgrHe41mvI7L89OM6ry8H1BbzXC1CJG5Jw/OYXhnBJf0C542auzegESTRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VqhxqQHS; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4769aef457bso57730921cf.2
        for <bpf@vger.kernel.org>; Tue, 08 Apr 2025 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744121939; x=1744726739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUED+YsizoYtLbuUa6Mn2CGrviLGvDgEueuSE8tfdgc=;
        b=VqhxqQHSrgG0NHPDtU978Aaig06cFv8kxFpUwFtp8DJWhHWT3kCkRnNu3hLdeA85Mg
         LoDWUFXB5ZZmJKHh4CzB1exYaEAM3H/e3V8aOav5/T68W+FMV8E5m2DD5Pvz/kzIIJbX
         aH3PCFa2omAn5F4/oMt1mtqQxQqLh5n7e9EFHt/ylplbaNjTTDdBfEOnCRV3VPslFRjc
         GXQxxCQoJUBqXdgEdZRArPc2j8Ka8yBny4T4n+Ihf25RCQKBvfvIpQrglKGAxmXvDPyx
         qbuhXI0LhnstYtJd/+fa22NxiI/WFk2ZGSNl0C4lgTuD1le8zhvKWNy5CGnyDj7IFRMw
         H7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744121939; x=1744726739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUED+YsizoYtLbuUa6Mn2CGrviLGvDgEueuSE8tfdgc=;
        b=JKCnSX+krZZi/+0tyO3aTOgYWJCHiKO44noDp2FIUMR6O1uVqLNmIAUAuTtGlCKvC9
         9ba3BppnI8e2cAhdEtEeGht7/1cHZp8il16qJSxfn4DxIzt1jBoDHhK83WZXB0sF7uva
         OeKmkNoCFv+3IxnZo+WLfxvoR1m+8TqiNqQ930g2s+mhv5YHS6u399QQkXeS6cNKCpfg
         tiRKefwR2HXha6qibEi4vJri3Vvk4hU4OFIedKGzLTEiPuESoi49GJykK5cjVFa1L2Da
         OpLmXzUHQ5DoJSRxE8emKZHY7FwZxj6yD6Bo2C8LnqeGocS/dMjptaeD2SPA7matjW/a
         KjPA==
X-Gm-Message-State: AOJu0YzsblfY7WOrCEudiWBZhlqWhMJe2ny8Y3Y/SgYGlYwhRyQAJ7O+
	n/knSRxZn0n/4OjlXupgsPVVboWV7yWJK4qS/jFQszxg8AwhW0sC8GNjkbUGzNTsfvrWj+Dfjvq
	znv588f2Mip2hek2miDS7c2xECIUjj5nKa8daN1lxlBt2TXab6Hbg
X-Gm-Gg: ASbGncvH+iYz1oQfeVf+kUUr5JL4X3bdZE9EtDkKcHnn1IQ6g77DBXKGF+PGbKZj5YS
	ZBjx46198QWetm1sI5J5pVS6QyHGRUPfRiWIOqhOKe//xUX8RsPx8bHrwgIfxPt9gOwE9YFcmez
	QhaGKiUY2+omjtkCSmsYzBE/H9I6g=
X-Google-Smtp-Source: AGHT+IFIhTvGae12W3Tf48cMLLSWVq125Yz7ZFcXjWUhP0aqaEKdzLe5CH8ZijLEEkcz+k7HaYWQTShUKE3lcrVa7Fc=
X-Received: by 2002:ac8:5956:0:b0:476:76bc:cfc4 with SMTP id
 d75a77b69052e-4792595b9acmr239939611cf.21.1744121938944; Tue, 08 Apr 2025
 07:18:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407140001.13886-1-jiayuan.chen@linux.dev> <20250407140001.13886-3-jiayuan.chen@linux.dev>
In-Reply-To: <20250407140001.13886-3-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Apr 2025 16:18:47 +0200
X-Gm-Features: ATxdqUFSGvKSj3SCrZXg0qfXO62DRsoebr6pzqkdURmDkUnvUfIhjveRN8CTtjk
Message-ID: <CANn89iJRyEkfiUWbxhpCuKjEm0J+g7DiEa2JQPBQdqBmLBJq+w@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next v3 2/2] tcp: add LINUX_MIB_PAWS_TW_REJECTED
 counter
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, mrpre@163.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, Antony Antony <antony.antony@secunet.com>, 
	Christian Hopps <chopps@labn.net>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 4:00=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> When TCP is in TIME_WAIT state, PAWS verification uses
> LINUX_PAWSESTABREJECTED, which is ambiguous and cannot be distinguished
> from other PAWS verification processes.
>
> Moreover, when PAWS occurs in TIME_WAIT, we typically need to pay special
> attention to upstream network devices, so we added a new counter, like th=
e
> existing PAWS_OLD_ACK one.

I really dislike the repetition of "upstream network devices".

Is it mentioned in some RFC ?

>
> Also we update the doc with previously missing PAWS_OLD_ACK.
>
> usage:
> '''
> nstat -az | grep PAWSTimewait
> TcpExtPAWSTimewait              1                  0.0
> '''
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>

