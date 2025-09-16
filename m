Return-Path: <bpf+bounces-68573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1D6B7D6FA
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1A01C013DB
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEE52D29DB;
	Tue, 16 Sep 2025 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmkBv8dQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040FC23B616
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 23:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065195; cv=none; b=CSNsO2NBG5/w3Xe7BIL3i6XcwhlehkdfbRY3He87rPwSRFFqq6SCzYfRiWDIoJ0W1o64Ewj93mMCeJeIrQmyTY2/TpNqYKw3iPlpTkBBr++e1RE1Xa89ynfGs6RoQs+RGi+w/1W4hNyq+vp0tD6e9D7Z5ipFenHQNDgwH0zIMYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065195; c=relaxed/simple;
	bh=E0d/hP1Dk9E8noVE/0JMoJUU4U4ojpWbvRJtWv4LtW8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Es4q7M11haj7nx3QMyJg2qgqlYWvi1j/9WoypPDIgE8y9ITVwtB+B+zykF69W/EJbo3T29/dLSC+qIDTGu73fJQ3Ce+9TXlr/JzC+gBNkAC9Olf20sLbWVuyluAZHQNGvj7l8l4mHQNximdXJcC5zsEhU6TTC9WN7CsVXvyKPSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmkBv8dQ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b54a74f9150so4229021a12.0
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758065192; x=1758669992; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D2yB0O5efrnXbVw3FE4oL4GU2n4ePSrPCiw293l0vy8=;
        b=AmkBv8dQ8nCqCRZvfh9vlbMlmyl5HPxMqH1fREHazYkLoGhrB5Riu9n06jiY+iNE75
         teDtSBp9625M3fPSzbSGue8URf2+QJprEbVeQeHXpqnCnAW9kfaS69f3Mun4NPQVskhb
         avZ2mCus0b0MENdrfbEb7NOFztKkvyY7LVWGiuO+gocHp2ARBbZ09x6JuYK/xO11tMYi
         Yc7dxK2HM3IXdgIAlExtXb29Efn3raMQJJ628GqsaPRc1LsUfyXAw698ddxVEfFXxrNA
         SU9QLkn7A1Ljny1jsXAwZT4ggTnIL59+BCg5O85+1a2wiTTZYVxdMrZjsNrLW/+bSGEr
         /TnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758065192; x=1758669992;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2yB0O5efrnXbVw3FE4oL4GU2n4ePSrPCiw293l0vy8=;
        b=d9/DQc7OP+BlQrRXAdYtEZqTW19oU1Epa53+n5T7mZ5gpn+8Qg8mm4tQfDLCs6HWyR
         qJipiRO5fkVK++Le6XolZrkw3GW2D030oeimnCLUz578DvsHVYlK+DUM3lfsWavXk749
         nRALMekd4e3VBJ3xjMxAZiSXPcmWDOEbJfJulVdXzbIXmZmqE/w32OiKeYqObVJ5RItl
         kSO63jz0+17wRxqYkUP2e1dtrmTh31mBks1g147QKc2vSEtSYPLU99BIQXG2oFnRwUOb
         mzv6qtwWnjnly/XmwOnhJSLuImuXDWlGlqn3P5jFBG4aMuP480a2AyU9J1EJfTQAtm0R
         NjXg==
X-Forwarded-Encrypted: i=1; AJvYcCWSYGzYZt25jvZZIwqyDKbQoVev3MJ1eV7an61TMGEFI5nE4sTSxxUmjTpNEkl2b4sUV+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YztiHlS8GbLpPmDbB1z3epSsRlm9Ubv4nq1kL95ayclFUTatqN7
	sH8llPvJsH+LkgxeaSwlMCS6v9ci/UKTlgqW/LbieXEC9M5wt5hjTT73ruAkkwq9
X-Gm-Gg: ASbGncvpoNKgn36yRWrhKNfJLewfkAQGB67cKD8Vsl3Qif3CWYLu3bxM7eW2MrvzTBg
	H7HlXdbzYKL9lu7CF2PlMdbgPBhoGuVYQSpUxUfQG6Pgy7CvYkSpaBjhaWrQtU4urNHwqzaPcom
	wOvB/rLXrB4es/E0gSdZfHafbKPwTDmTqMHn+Of7Bfm/wSpWlbTDO+lsfu2033tqkQJcQKo0gJJ
	qvRRaYk+gkNf/qy2HKsZDZZ7aqoG19KFDnLxDhKiWovCz4HowAz4oDvFeXdRKaVsFoupYWc47Ap
	kEZ8RDv7NSbmv0kLmxWtdHUxZ55hZH4bmU6N1bXOCehXrCo1Bzt5/lxqQ86g1kircDGmO4HzSIa
	ltciX0xrnStBc7/C0fu01NaAD9Aq/DibT/v12EIDxLTSahw==
X-Google-Smtp-Source: AGHT+IEMKmgUHGM9E8z17lZGhJ+vEd+ae71HI5iz9ry4CFGSbYVnFyu8b7LIGdZOWGPLad0KdqxjWg==
X-Received: by 2002:a17:902:ec92:b0:252:8cc1:84a3 with SMTP id d9443c01a7336-268138fdec3mr401045ad.43.1758065192266;
        Tue, 16 Sep 2025 16:26:32 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a1:9747:e67f:953a? ([2620:10d:c090:500::4:432])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267e9372e86sm19435835ad.136.2025.09.16.16.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:26:31 -0700 (PDT)
Message-ID: <ea1536afc399eeda111f6f8e7c45ba81108fef6d.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: support nested rcu critical sections
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko	
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau	 <martin.lau@kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	kernel-team@fb.com
Date: Tue, 16 Sep 2025 16:26:30 -0700
In-Reply-To: <20250916113622.19540-1-puranjay@kernel.org>
References: <20250916113622.19540-1-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-16 at 11:36 +0000, Puranjay Mohan wrote:
> Currently, nested rcu critical sections are rejected by the verifier and
> rcu_lock state is managed by a boolean variable. Add support for nested
> rcu critical sections by make active_rcu_locks a counter similar to
> active_preempt_locks. bpf_rcu_read_lock() increments this counter and
> bpf_rcu_read_unlock() decrements it, MEM_RCU -> PTR_UNTRUSTED transition
> happens when active_rcu_locks drops to 0.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

[...]

> @@ -13874,22 +13874,22 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
>  		}
> =20
>  		if (rcu_lock) {
> -			verbose(env, "nested rcu read lock (kernel function %s)\n", func_name=
);
> -			return -EINVAL;
> +			env->cur_state->active_rcu_locks++;
>  		} else if (rcu_unlock) {
> -			bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, clear_mas=
k, ({
> -				if (reg->type & MEM_RCU) {
> -					reg->type &=3D ~(MEM_RCU | PTR_MAYBE_NULL);
> -					reg->type |=3D PTR_UNTRUSTED;
> -				}
> -			}));
> -			env->cur_state->active_rcu_lock =3D false;
> +			if (--env->cur_state->active_rcu_locks =3D=3D 0) {
> +				bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, clear_ma=
sk, ({
> +					if (reg->type & MEM_RCU) {
> +						reg->type &=3D ~(MEM_RCU | PTR_MAYBE_NULL);
> +						reg->type |=3D PTR_UNTRUSTED;
> +					}
> +				}));
> +			}
>  		} else if (sleepable) {
>  			verbose(env, "kernel func %s is sleepable within rcu_read_lock region=
\n", func_name);
>  			return -EACCES;
>  		}
>  	} else if (rcu_lock) {
> -		env->cur_state->active_rcu_lock =3D true;
> +		env->cur_state->active_rcu_locks++;
>  	} else if (rcu_unlock) {
>  		verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_=
name);
>  		return -EINVAL;

Nit: active_rcu_locks increment in two places can be avoided e.g. as follow=
s:

        if (rcu_lock) {
                env->cur_state->active_rcu_locks++;
        } else if (rcu_unlock) {
                struct bpf_func_state *state;
                struct bpf_reg_state *reg;
                u32 clear_mask =3D (1 << STACK_SPILL) | (1 << STACK_ITER);

                if (env->cur_state->active_rcu_locks =3D=3D 0) {
                        verbose(private_data: env, fmt: "unmatched rcu read=
 unlock (kernel function %s)\n", func_name);
                        return -EINVAL;
                }
                if (--env->cur_state->active_rcu_locks =3D=3D 0) {
                        bpf_for_each_reg_in_vstate_mask(env->cur_state, sta=
te, reg, clear_mask, ({
                                if (reg->type & MEM_RCU) {
                                        reg->type &=3D ~(MEM_RCU | PTR_MAYB=
E_NULL);
                                        reg->type |=3D PTR_UNTRUSTED;
                                }
                        }));
                }
        } else if (sleepable) {
                verbose(private_data: env, fmt: "kernel func %s is sleepabl=
e within rcu_read_lock region\n", func_name);
                return -EACCES;
        }

        if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
                verbose(private_data: env, fmt: "Calling bpf_rcu_read_{lock=
,unlock} in unnecessary rbtree callback\n");
                return -EACCES;
        }

[...]

