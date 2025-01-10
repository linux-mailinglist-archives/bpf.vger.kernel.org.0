Return-Path: <bpf+bounces-48521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFC3A0885E
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 07:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AD2E7A20C1
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 06:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9708E2063FB;
	Fri, 10 Jan 2025 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeM+PYVl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF3E17B500
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736490471; cv=none; b=YqAuz08/6mpsNrEsb/P1eFJXjOc6/Nd3Nq6ldZJCDvk3PpmSznZ680VSx50Cuvqa/wpKPLp0PHEFQ7zKEa7I+y8ravyHJkGRhTYHEuLQtgFT0UHk5O7EyVoFzPgB3oTj+i25va/7OJwEqmFUn3YPRGPwZo6wTcHsI+1TXX/vqBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736490471; c=relaxed/simple;
	bh=WqN5N2Pmd+zViod27BPGyX03fmfMGBeq2MYZijpZdK0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=b4V451S3rrYjt++yY+isUC6nD+CGrXSI3IA8O4PuDBblbo0YqhaN0qJt39yBSrtwdFsSnoWHmMtuDqSWPAofla4kTj0lHMu4/NmPuuY4XeAxUEPGsUzTio/HXuSWWG469xhxVafpS4+qUorK35Qq9NsXGCnu3NUVhkYuqu+5RzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeM+PYVl; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30229d5b229so14325111fa.0
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 22:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736490467; x=1737095267; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gKsBvKrsjze7+XL8+c1KiSIaOfGypt0yDkxgdK3PhXU=;
        b=GeM+PYVl04Irbjvmt6KolWBvRAUkjH893UXuYv4FbtIsL3WbvN5EeOx/bJdDG/AD6H
         3yBNezrhLBkqJ1mNYLIUtsYSEOMrmqBqrHdOy/w0QEEM5iCOpCfYA+bFYv12yH0rUIpB
         WI/7118aHarp0Th+eSZRxvDrOfkO81BrgRmsbnDMqcLfSC6KqFl6Wfe6P7XTwGb9bjL9
         TQ9JWyknDFq50jSzFjqgCvicpfeuHclqBEkv08pW9Bi53OLz8LWlp4CW14lBObzg7mmJ
         KuDPxuJkpZOkswCTbCE2wvGnkbJOfmaQlajeo/QzJhjKuyXsyADHZ4yXdFT/NdTgp8SZ
         mceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736490467; x=1737095267;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKsBvKrsjze7+XL8+c1KiSIaOfGypt0yDkxgdK3PhXU=;
        b=Mw0oeW+sl5+2Tz7bUlZfloZJCV1ZPA0GlJFK7nwHShpgK5jBFF2srdEBFJvE+MENQT
         hUSzF/LvcVkL9Ovodf4ujncIEwuQxagx8BfX0XrTKcqF/KGP4eB+c5BSN1diQHZAVFJU
         qkcQDCJlh2aERDX66iJfrw7ly3Cm0hDV5AhMG+UE8THLlEy0toEALz136of8ZKMCvIXD
         NuOVkAx57ttb5qiwqKi1PC8bVtydbE58BaVHUDZXeTR4bheBCfEzIzaZ4UHj3NAhZ+Hq
         3jdEWr/L6UYYZaCAHyVPw0Qpi7WZWn34BaBVUZtjflE5uzhsDXxKSmR6YsBL73cy/JtJ
         SQ2Q==
X-Gm-Message-State: AOJu0Yzw4H4exR4xs8uUj+6NAGuivO+kBIw+rRIVKJWdKJyj7SVyqnsK
	blvVZ06bU4eybW0JPgkcVmCx8xdbElwX+BLkBrN3G7SuFvugrno3GupYIFftZUnh8NSuhkk7G8/
	7jLEY22jxJicwsT7AUnEZbH+oPhK9mj1L
X-Gm-Gg: ASbGncum7rcVzahjYU0eg4lLJvjFFAKxU1W16L/45pbluPbXIdM5hPsKIsTFIYhpu6S
	KNiiwbmNecfupS60AQo30kfcfgJyO+e0rYWRY
X-Google-Smtp-Source: AGHT+IHY0I3B/kL34FLYKl5CfX0v8VpcuMcQR0DPeg4TNbi8yu5lf6FvR2LF5nYfIYesUAsqq9AZnPbSKlEI8sjQ2uM=
X-Received: by 2002:a05:6512:3a84:b0:540:c349:a81b with SMTP id
 2adb3069b0e04-542845d15d6mr3272289e87.48.1736490466954; Thu, 09 Jan 2025
 22:27:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: K V V <krishnavivek.vitta@gmail.com>
Date: Fri, 10 Jan 2025 11:57:58 +0530
X-Gm-Features: AbW1kvbFFzCuEYwad2wPsqfl0huDVpaOZEf5_XCePcBTMiNAEMYnNIvsJ6eovhY
Message-ID: <CALzDPu2Mq6Yg5PQk4HxsHNY=iiMUbuGJMBCGkfY_LJs+UOz1Qg@mail.gmail.com>
Subject: Help getting child process id
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi experts,


I am looking for help in fetching the child process id created through
command: =E2=80=9Cunshare -p -f -m /bin/bash=E2=80=9D. This command creates=
 a new
process in the new pid and mount namespace. The newly created process
owns both the namespaces

I am able to fetch the newly created pid namespace id and mount
namespace id using the below calls.

BPF_CORE_READ(current_task_struct, nsproxy, pid_ns_for_children,
ns.inum) and BPF_CORE_READ(current_task_struct, nsproxy, mnt_ns,
ns.inum);

Can you help me to retrieve the pid of the newly created process from
the running process. Have used the below program to get the child pid.


                struct list_head *child_list;

                struct task_struct *child_process;

                pid_t child_pid =3D 0;

                child_list =3D BPF_CORE_READ(current_task_struct, children.=
next);

                if (child_list !=3D NULL)

                {

                    child_pid =3D 121;

                }



                // Check if the list is empty

                if (child_list =3D=3D &(current_task_struct->children))

                {

                    child_pid =3D 122;

                }

                else

                {

                    // Use BPF_CORE_READ to get the task_struct of the
last child

                    child_process =3D BPF_CORE_READ(child_list, sibling);

                    child_pid =3D BPF_CORE_READ(child_process, pid);

                    //child_pid =3D 123;

                }



I always get the child_pid as 122, though the child has been created
successfully using the above command.

Any pointers to fix/retrieve the first child of the process.




Thank you,

--Krishna Vivek

