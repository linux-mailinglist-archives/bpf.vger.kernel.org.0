Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF7D573AC8
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 18:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbiGMQDO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 12:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237107AbiGMQDN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 12:03:13 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD32A5006C
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 09:03:12 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o21-20020a17090a9f9500b001f0574225faso1816853pjp.6
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 09:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=wQFf5DtzT/85726aL6fYNeFoAW7JfAnPXxyXMxrgKiQ=;
        b=a9/zMiTHcqWMd+J3C257IhXNuu5PxPM5fDb6TU3PHWOB1kgt3Lm39dhnU2VIu7xHgn
         uwIP7Xa89qJOVQLs1H7NqaHGH8civvoBQ9K3MDohaRkvS1R87zi5oxCv2rXb+VCwTS18
         MYO+kIwk1DIEKegBGOk3UIG/w9ElHvgQR0HS/0ybAIQtEx4A68l1BUOothu89sBs39cj
         WlV9FXlzcw/8r97hVav6900fw2Syu8qYMY/68N4XOtzI22NW5ftg5Xj9A9QPfTb690AF
         pmu3yVc8+iF/IAGSUNKn1fpqTYZSZ1+d0TfRagV12IUaJSt4H89mZvtRfzrXSC9F6FO3
         MZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=wQFf5DtzT/85726aL6fYNeFoAW7JfAnPXxyXMxrgKiQ=;
        b=YGvs2eQwmwZ6q4ts8BPcZosNKtztmWJXR72I9m/J9h0t1Iqsk1nYP/jDAG+qnSR+Cw
         VEIPffiy15AC6BZxa3zP0Neua7ApD4/JDOzYeeCXzt7CvSwTV30dbxVOPqgNYvnTz8qe
         ut1Ym5+UDodg+ZVhvmSDMfwueyEcev2a6QNbTf5vUyd7ck06sqdZptaUuQx7cKe9rN8G
         KuMNrQObRWyFVA4FNiMU5GZ/apXql8YJifA5hb1KVmjSeuZ/z3u/xufFijBVsfZhGbGe
         bbRERon0nn9OVoXRqJZSzq8urRyt0SZCXodn41Z5Dvm7iisL5IUTYqTC5j5K2bFUCQl+
         3zaQ==
X-Gm-Message-State: AJIora+HdY54BwdKX1nNFVWCby7M9UgR2cZYn9IgHVDYypsYPD/M4jBU
        x+7qAM3c2NVmnXEfsQ7RxIvmDpE=
X-Google-Smtp-Source: AGRyM1v1WK0jGrCJMEUKVpJExOzA2zo4Sy0PuOQgCBFakMKx7sRoLxDnrQNYqJ3WwE+GQGCvOdzvH3w=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:ad0:b0:4e1:2d96:2ab0 with SMTP id
 c16-20020a056a000ad000b004e12d962ab0mr4006442pfl.3.1657728192181; Wed, 13 Jul
 2022 09:03:12 -0700 (PDT)
Date:   Wed, 13 Jul 2022 09:03:10 -0700
In-Reply-To: <4411407.LvFx2qVVIh@pwmachine>
Message-Id: <Ys7svh29R5jA6QAr@google.com>
Mime-Version: 1.0
References: <20220713144439.19738-1-flaniel@linux.microsoft.com>
 <20220713144439.19738-2-flaniel@linux.microsoft.com> <CAADnVQLVSoetPd5d1_tf=KkGou9iUWkt3ovgi8eeCWtbJtRUiw@mail.gmail.com>
 <4411407.LvFx2qVVIh@pwmachine>
Subject: Re: [PATCH v3 1/1] bpftool: Align dumped file generated header with skeletons.
From:   sdf@google.com
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gMDcvMTMsIEZyYW5jaXMgTGFuaWVsIHdyb3RlOg0KPiBMZSBtZXJjcmVkaSAxMyBqdWlsbGV0
IDIwMjIsIDE2OjQ3OjE3IENFU1QgQWxleGVpIFN0YXJvdm9pdG92IGEg77+9Y3JpdCA6DQo+ID4g
T24gV2VkLCBKdWwgMTMsIDIwMjIgYXQgNzo0NSBBTSBGcmFuY2lzIExhbmllbA0KPiA+DQo+ID4g
PGZsYW5pZWxAbGludXgubWljcm9zb2Z0LmNvbT4gd3JvdGU6DQo+ID4gPiBUaGlzIGNvbW1pdCBh
ZGRzIHRoZSBmb2xsb3dpbmcgbGluZXMgdG8gZmlsZSBnZW5lcmF0ZWQgYnkgZHVtcDoNCj4gPiA+
IC8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoTEdQTC0yLjEgT1IgQlNELTItQ2xhdXNlKSAq
Lw0KPiA+ID4gLyogVEhJUyBGSUxFIElTIEFVVE9HRU5FUkFURUQgQlkgQlBGVE9PTCEgKi8NCj4g
PiA+IEhlbmNlLCB0aGUgZHVtcGVkIGZpbGUgaGVhZGVycyBmb2xsb3dzIHRoYXQgb2Ygc2tlbGV0
b25zLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEZyYW5jaXMgTGFuaWVsIDxmbGFuaWVs
QGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+DQo+ID4gPiAgdG9vbHMvYnBm
L2JwZnRvb2wvYnRmLmMgfCAyICsrDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS90b29scy9icGYvYnBmdG9vbC9idGYuYyBi
L3Rvb2xzL2JwZi9icGZ0b29sL2J0Zi5jDQo+ID4gPiBpbmRleCA3ZTZhY2NiOWQ5ZjcuLjA2NmEw
YWNkMGVjZCAxMDA2NDQNCj4gPiA+IC0tLSBhL3Rvb2xzL2JwZi9icGZ0b29sL2J0Zi5jDQo+ID4g
PiArKysgYi90b29scy9icGYvYnBmdG9vbC9idGYuYw0KPiA+ID4gQEAgLTQyNSw2ICs0MjUsOCBA
QCBzdGF0aWMgaW50IGR1bXBfYnRmX2MoY29uc3Qgc3RydWN0IGJ0ZiAqYnRmLA0KPiA+ID4NCj4g
PiA+ICAgICAgICAgaWYgKGVycikNCj4gPiA+DQo+ID4gPiAgICAgICAgICAgICAgICAgcmV0dXJu
IGVycjsNCj4gPiA+DQo+ID4gPiArICAgICAgIHByaW50ZigiLyogU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IChMR1BMLTIuMSBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gPiAqL1xuIik7DQo+ID4gVGhp
cyB3YXMgZGlzY3Vzc2VkIGVhcmxpZXIuIEl0J3MgaW5jb3JyZWN0IGFuZCB3ZSBjYW5ub3QgYWRk
IGp1c3QgaGVhZGVyDQo+ID4gdG8gdm1saW51eC5oDQoNCj4gT29wcyBzb3JyeSwgSSB3aWxsIHNl
bmQgYSB2NCBkcm9wcGluZyBpdC4NCj4gTm9uZXRoZWxlc3MgY2FuIHlvdSBwbGVhc2Ugc2VuZCBt
ZSBhIGxpbmsgZm9yIGEgZGlzY3Vzc2lvbiBhYm91dCB0aGlzPw0KDQorMSwgR29vZ2xlIG9ubHkg
Z2l2ZXMgbWUgdGhlIGZvbGxvd2luZzoNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYnBmLzg3
Y3ptd2UyNmMuZnNmQHRva2UuZGsvVC8NCg0KKHdoaWNoIGlzIHNvbWV3aGF0IGluY29uY2x1c2l2
ZT8pDQo=
