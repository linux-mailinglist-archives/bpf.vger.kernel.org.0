Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709C650ABAE
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 00:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391986AbiDUWyw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 18:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391899AbiDUWyu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 18:54:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F05933E8A;
        Thu, 21 Apr 2022 15:51:56 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23LL0nDR032363;
        Thu, 21 Apr 2022 15:51:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ED4fEoInZ1qt2zuKJSre3NN/16dUY+9k7jRa4n1Uyac=;
 b=REkYd/4Jero97qPOrO7mylrU5DpO4Tlm2RBapStJ/B5kcY6Tzf1bPlkKSHql8/7B0bZf
 1nTyQijSBc0DfFoNISP4wAapEcKjhpEOFy/H/760Tp842twwkbsMMW8eFaYU90MIS4U6
 acmUWW5NcnDVr1Z6CRrWWYU+OnzZFRAnXJk= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fket40kw0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 15:51:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7uDxi4L/NSNDLdpKzUrFo05e2x8385T7Q1vHwVqdoL1c2+rCj72XODQwO87f8PnM/3X+gN/2uGS7sV/tSXsmGwOcaolPOo4mUFliQj93nVREE6/tC3xmf9C3rd/X3X2i1bpEEDiS1CnicAEl8lSSyQE/YEdRNlMd6F1AMn0wN6qjQQ1tQMY5ITr3pc0qp4MV2xP+avmCbseIqB9XLa/0vNXVjs3b7u0sEiFuIvGcQMuKhIRtI/ZntgvOrfv1FJrrxTJIXwcww1Ic3OztlGXP6LKH77pdVPUqFESsmpE5QQ89mPkUloOAUJTQ9m983ZKc1GHByilA+OR0zQx9jPIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ED4fEoInZ1qt2zuKJSre3NN/16dUY+9k7jRa4n1Uyac=;
 b=cSPlEt6gXruAIWWYW60WI++0WfvgWj9YZiOoUfDdapKDlvgKu0mySYEFdPFMBQH+0QXI3EUlo0Hfg8lhP0UFituQeaYoRaEUxZis2jVv+NO1TCH/Sy937onV3q3iW2j+/n7Y4VV5tfbffU87DR46ELwi4FHuIDZMQQzsd4+PItZKXZtRONmw8gfwBuCRzr8+5nJ1kiP9WBK6G5VDhHdYCLdWHeaqGNszeBTYtO8RYtMlF9u0AhUpF5YE3Zru048DRidl/CWo2Sy6jmZkZBxmvlcjRDiLD1AzgSe6BWPnh0tV7T6koFICINrqCrd1s6qE/b92BHM46wHIR6gg/DQlFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BYAPR15MB3368.namprd15.prod.outlook.com (2603:10b6:a03:102::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 21 Apr
 2022 22:51:52 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::20d2:26a2:6cb1:3c4b]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::20d2:26a2:6cb1:3c4b%7]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 22:51:52 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Song Liu <song@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf] bpf: invalidate unused part of bpf_prog_pack
Thread-Topic: [PATCH bpf] bpf: invalidate unused part of bpf_prog_pack
Thread-Index: AQHYVVFO5makbPGsXEqvzLt6DCKkwaz6mnqAgAAexN2AAAuPAIAAHgIAgAAGqwCAAAquAIAABfyA
Date:   Thu, 21 Apr 2022 22:51:52 +0000
Message-ID: <8F788446-899C-4BA3-8236-612A94D98582@fb.com>
References: <20220421072212.608884-1-song@kernel.org>
 <CAHk-=wi3eu8mdKmXOCSPeTxABVbstbDg1q5Fkak+A9kVwF+fVw@mail.gmail.com>
 <CAADnVQKyDwXUMCfmdabbVE0vSGxdpqmWAwHRBqbPLW=LdCnHBQ@mail.gmail.com>
 <CAHk-=whFeBezdSrPy31iYv-UZNnNavymrhqrwCptE4uW8aeaHw@mail.gmail.com>
 <CAPhsuW7M6exGD3C1cPBGjhU0Y5efxtJ3=0BWNnbuH87TgQMzdg@mail.gmail.com>
 <CAHk-=wh1mO5HdrOMTq68WHM51-=jdmQS=KipVYxS+5u3uRc5rg@mail.gmail.com>
 <1A4FF473-0988-48BE-9993-0F5E9F0AAC95@fb.com>
 <CAHk-=wi62LDc5B3DOr5pyVtOUOuLkLzHvmZQApH9q=raqaGkUg@mail.gmail.com>
In-Reply-To: <CAHk-=wi62LDc5B3DOr5pyVtOUOuLkLzHvmZQApH9q=raqaGkUg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e91bd8a-f851-468c-69c5-08da23e986e3
x-ms-traffictypediagnostic: BYAPR15MB3368:EE_
x-microsoft-antispam-prvs: <BYAPR15MB3368E7FA9ECAE2ED9B0309CBB3F49@BYAPR15MB3368.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dLDp105dHiXIZnnN3iwVam2BdqrU0Kf0KWHdBGdEpQOzLFBDeT6ER6fp5bDj8zQOx+Iolg724spujMF8AbypLx0v2jvmnom936ulqjP046gTB5vDd+hk4KggT0wjFnTSFmIH9WXd2LHTL8uA72yGQflZ/bZA09OJTH9sxc+d/a1UOMhowqbdS2MKrMJZOTO0WoSYmkaL+C1ERvRhuemvjx1xWprL/vErU3+em+uYpf00x5rfkQCLNOKnL6yqjgbMFH89UtpblY7C7m++apkbxKclj5agV0ZbVcWMyXhXc2wjZIXcwdRF1vzWIz/1qMN0MnZeY8vkKRTXbI9DwshH/Bq8PTHHTrcQ3E0Q9l+TS/USlkxRsnJ69/8T6i+G38Co2pkd59jvydtE+cZO+6I6bADKTULD0X1OMrTR7bFZFRD6tbS1CTrlB9UMpdCYuth5OBfD2uPSsafRaDvaurjAuzp3Wu5gk21XojEqRR/nWa2riVN+VAXZU86SNKybJSid8qGC/ytV9EwJDw7Lv8WEFBZfXSO7aFrCP57Lm7vf+5aflgHPIMAf5TSz09ScKYOlFRu4ZtpYZ99ZCHXY0KiQIHwhbnEoY8ID25Cz5yYKhjIGFRMOa5HBx/DdPrrJL2wV4OkQ0bjVKG40kS1vaYU2f1IL1ausshcxraB395xjmstBayvwWHKgmIq6M6TNL7aFnr03EEFxK/D42D/1AqC9S2cRkqf+4ZGVEPkg+1YF8iZEmgr9Mvqtn0jiI1qu5IKD9FGk70gy2UL4UVNYm+7NNv62egnwpdBCUUPP/WkMLpycnmKD0WPHnocU4aVtUVA8k2zDWC+JfQUTu2HZCD0vRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(7416002)(33656002)(5660300002)(508600001)(316002)(8936002)(86362001)(53546011)(71200400001)(122000001)(2906002)(2616005)(6506007)(966005)(36756003)(6486002)(54906003)(110136005)(6512007)(4326008)(38070700005)(8676002)(38100700002)(64756008)(76116006)(66946007)(91956017)(66556008)(66446008)(66476007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek0xNzhVSklRdWUzYjJJVmw0dUVubmJMb1NGTEc4ck4xVTBwTzhDQzdhUDlC?=
 =?utf-8?B?YjNMNVU1aXMrVnhFR3VnMVJZaHBIVVBJV2E4ZVF1bCtDRWFTSlAwQm9hU3Bx?=
 =?utf-8?B?UWpQK1pFZ3Q1c3BvUmVUYnBDcEZQWkp6STZKNUV5d0dlL3hLeFhGeXRIb1Iv?=
 =?utf-8?B?UVJ0TWQ4THZmbW50K2FRYmZaTXRObW1PUkFzSDk2ZS92U0duWDgwNGowb2ZD?=
 =?utf-8?B?MmJka1QvOTFEckZES2d2QmJWaUxIdE96RGkyYW9DSVZaUEhvY2NEd2hWaFN5?=
 =?utf-8?B?TTlnM3FNb2JOTnNmeFk4ek9XdnJLNlpFbWt0czhxTFErbW9iaVpZbU9abnp6?=
 =?utf-8?B?RER6TmZlK2dyRHRZQ095aXQwZVlVUXF1ZEh4cm0wRWtWejRFM00zNktNc1ZV?=
 =?utf-8?B?Mlltdmc1ckljQWNSMjN0b1pGNzVoTWhZNUg4dmRjODJRaWt5Wks5TXRHcktQ?=
 =?utf-8?B?ZllWeVdNa0xOU3FVbU9mV1RKdGh1RDZJVHpWMXFmOHpFU1BES3ZCRDNOMUdx?=
 =?utf-8?B?YVQrS0N0SWZpcm96cnJCZTgrZ3JEYWdxRytzbDhvQVlCMEdPVVhHWTdoZ0Fw?=
 =?utf-8?B?MHVDMnRtNG5USmhYcGxPSUtPYjVkd1JCNFV5NzNzQVg2aGQvS3REemxPZkFF?=
 =?utf-8?B?bWNSalo0VHAvM290bDZRcFlCcDhqTitsdFVOdndCTFZsYnF6c0pFMVVna2FD?=
 =?utf-8?B?ZEJqODBDSTFnUStHczJOSnhjUlBDMXNtSDdqaTdXOGh4cmxVcWdRZlZyNWEz?=
 =?utf-8?B?YkhkRVlMYmtSOEZtQ0FYaStrdDh5RWVLQTg5UlpKNG1RS2pTb1dZckdtVWEx?=
 =?utf-8?B?WUtKNVJnbVJCNnJ4bjRKdjZ3Mk8vOGtMaCtadFY1dElienFjSjNPRFI0THhw?=
 =?utf-8?B?ZWtKSy8yRnhkamZNQ25XUXBNTUhWbGs2NHhpOWVHS2pnQlh3Z2dDdmxBZmc1?=
 =?utf-8?B?THBDb1FTR3Qwd3drMFpjYXJJdUFGdDhqOGk1YVpNR3dLbVdqUU96SG85SHA4?=
 =?utf-8?B?bEw2bHl2alN1MVJPNG1KK2RTQU1PdDJCbDhKWXNVSmlIM2tKV0FFK0ZVdk11?=
 =?utf-8?B?bU9SdVVtR1V1dXp5SWtlYlFTTUFWZjdMWXRIYWlaSDlXWjVKLzl4dytTS01s?=
 =?utf-8?B?K28vendXMDdvY1BiMW5kWnJ2YzVjVk5YVkF2RVFMZ2kyVVYrMDhxWFRNV3Nr?=
 =?utf-8?B?SnM3dXBNSnQvdGRUc2xNYi9XTkM0VHpDK204dFpDTUJkREwyVzdEVjZoTFU5?=
 =?utf-8?B?c0d0emVjdmFWL3ZUSTZzS3doaG9pSXptekNmeDlsRmtQSUVuM0hodXpQVllZ?=
 =?utf-8?B?cTUyNkZjTWFka2xxMG1Rcm8rSy9tSmpTNEJVVHlyM28vV0tHeHA5SUZKeVVn?=
 =?utf-8?B?ZU1JT2oyWDZySmlZd0MyZ2l2R3NsRUQ5YXk1T2Njdlo3c2JtUGJxM0dCQnhu?=
 =?utf-8?B?dXUyczN6ZThzY0grTGJPbWN0WDNld0lobUp2b1FPRXFBUk1RUDQ1RWxkMmtD?=
 =?utf-8?B?NW5hbHo5NlAwUDdSckVUb2x3UDcxd0ROL1BGbFJmbzNGaDRlZzJqRElEd1c4?=
 =?utf-8?B?L3RNQk03d04yU2M4WnpCTXFUSUxvcVlPUlltbmgzMG5kSXNPcGZMNCsvZlQy?=
 =?utf-8?B?QllkSzhiSjVYNzFFUlVPYUNWTGdqQTR2N2lhREpCZVlVcXpQdUV6VWpkNWZ0?=
 =?utf-8?B?R2JRQXpmUnRSUklxdXB0U3loZFJYYThGMDVUZWRMSlp0aUw3RkZJY3hKcDBn?=
 =?utf-8?B?bmo3YzFiMERxTG14R2M2RXdPSFR6WFIxOExXK3ZJWjJjR2ZqVWxWalNhMWdQ?=
 =?utf-8?B?WWpmdVMyU2J1Sk9aR0oxUUhWZ1hNWjFsbFJmMUtHSlU3VWRoU2hTb01acVFk?=
 =?utf-8?B?ZjBWZzN1VmxDWjBJa2NRUmZUSXREQlBVRVVBZGk5dzBsY3psalVnY0NublVW?=
 =?utf-8?B?RzZLVUZzcFJVRlg5T01YTkFYQmd0Vkh2ZWFVMDRHODB6VVN2NGozTkxDQlV0?=
 =?utf-8?B?TEVWVytyZnEvWEZXM01XR1dzZGUrV2p3UWRJQ3ExRHZaWXZtaHZFcW45VXlC?=
 =?utf-8?B?S0cwMHRCYmhWRnRtcVVwVW5Tall6UFhEdmticFVxbElwZ01UWHdqVFQ1N3I5?=
 =?utf-8?B?aFlpOGp0NktQeTJhVnF5ZkROU1c1eWFpMHFMSlRueEdqdy9lWjNvUFhrY3BY?=
 =?utf-8?B?K0xFY0xiLzVYdUs2M3YvZ1ZEako5TGJaWTN5ZmxSdmZ4T0w4ZkpMNWFIcFJY?=
 =?utf-8?B?MWtBd0cwc2lwemRSNEgxcmxLUUx1L1NZUnRjcEgzNWl5WVplYUFQZVF4T1k4?=
 =?utf-8?B?MGJtSWhoUWlrbXU4REV3QjVGZjZnMHZGOFVFQjFlcERQdGZwK2E3ZmZKdXQx?=
 =?utf-8?Q?WrNSpGVJAgkOJZnIvGVRiLLHJdATsgYbdAbHO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4612DB066BDBF49B0670740E032F103@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e91bd8a-f851-468c-69c5-08da23e986e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 22:51:52.3436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wm3YDflYFgOx4rnZ+YnKcz0+5f4DuDaZcPI6BIugYZ/Z680Tlazlc3VoIXKNOQU0JmPZPc8992mIvQhTSPLTQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3368
X-Proofpoint-ORIG-GUID: KVXdXwuqJLTm5BVAy-3oa1f_Vz-blI1b
X-Proofpoint-GUID: KVXdXwuqJLTm5BVAy-3oa1f_Vz-blI1b
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-21_05,2022-04-21_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SGkgTGludXMsDQoNCj4gT24gQXByIDIxLCAyMDIyLCBhdCAzOjMwIFBNLCBMaW51cyBUb3J2YWxk
cyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBB
cHIgMjEsIDIwMjIgYXQgMjo1MyBQTSBTb25nIExpdSA8c29uZ2xpdWJyYXZpbmdAZmIuY29tPiB3
cm90ZToNCj4+IA0KPj4gSG93ZXZlciwgd2UgY2Fubm90IHJlYWxseSB1c2UgdGhlIHNhbWUgZnVu
Y3Rpb24gYXQgZnJlZSB0aW1lLiBUaGUNCj4+IGh1Z2UgcGFnZSBpcyBSTytYIGF0IGZyZWUgdGlt
ZSwgYnV0IHdlIGFyZSBvbmx5IHplcm9pbmcgb3V0IGEgY2h1bmsNCj4+IG9mIGl0LiBTbyByZWd1
bGFyIG1lbXNldC9tZW1jcHkgd29u4oCZdCB3b3JrLiBJbnN0ZWFkLCB3ZSB3aWxsIG5lZWQNCj4+
IHNvbWV0aGluZyBsaWtlIGJwZl9hcmNoX3RleHRfY29weSgpLg0KPiANCj4gSSBhY3R1YWxseSB0
aGluayBicGZfYXJjaF90ZXh0X2NvcHkoKSBpcyBhbm90aGVyIGhvcnJpYmx5IGJhZGx5IGRvbmUg
dGhpbmcuDQo+IA0KPiBJdCBzZWVtcyBvbmx5IGltcGxlbWVudGVkIG9uIHg4NiAoSSdtIG5vdCBz
dXJlIGhvdyBhbnl0aGluZyBlbHNlIGlzDQo+IHN1cHBvc2VkIHRvIHdvcmssIEkgZGlkbid0IGdv
IGxvb2spLCBhbmQgdGhlcmUgaXQgaXMgaG9ycmlibHkgYmFkbHkNCj4gZG9uZSwgdXNpbmcgX190
ZXh0X3Bva2UoKSB0aGF0IGRvZXMgYWxsIHRoZXNlIG1hZ2ljYWwgdGhpbmdzIGp1c3QgdG8NCj4g
bWFrZSBpdCBhdG9taWMgd3J0IGNvbmN1cnJlbnQgY29kZSBleGVjdXRpb24uDQo+IA0KPiBOb25l
IG9mIHdoaWNoIGlzICpBVCpBTEwqIHJlbGV2YW50IGZvciB0aGlzIGNhc2UsIHNpbmNlIGNvbmN1
cnJlbnQNCj4gY29kZSBleGVjdXRpb24gc2ltcGx5IGlzbid0IGEgdGhpbmcgKGFuZCBpZiBpdCB3
ZXJlLCB5b3Ugd291bGQgYWxyZWFkeQ0KPiBoYXZlIGxvc3QpLg0KPiANCj4gQW5kIGlmIHRoYXQg
d2Fzbid0IHBvaW50bGVzcyBlbm91Z2gsIGl0IGRvZXMgYWxsIHRoYXQgbWFnaWMgIm1hcCB0aGUN
Cj4gcGFnZSB3cml0YWJseSBhdCBhIGRpZmZlcmVudCB2aXJ0dWFsIGFkZHJlc3MgdXNpbmcgcG9r
aW5nX2FkZHIgaW4NCj4gcG9raW5nX21tIiBhbmQgYSBkaWZmZXJlbnQgYWRkcmVzcyBzcGFjZSBl
bnRpcmVseS4NCj4gDQo+IEFsbCBvZiB0aGF0IGlzIHJlcXVpcmVkIGZvciBSRUFMIEtFUk5FTCBD
T0RFLg0KPiANCj4gQnV0IHRoZSB0aGluZyBpcywgZm9yIGJwZl9wcm9nX3BhY2ssIGFsbCBvZiB0
aGF0IGlzIGp1c3QgY29tcGxldGVseQ0KPiBwb2ludGxlc3MgYW5kIHN0dXBpZCBjb21wbGV4aXR5
Lg0KPiANCj4gV2UgYWxyZWFkeSAqaGF2ZSogdGhlIG90aGVyIG5vbi1leGVjdXRhYmxlIGFkZHJl
c3MgdGhhdCBpcyB3cml0YWJsZToNCj4gaXQncyB0aGUgYWN0dWFsIHBhZ2VzIHRoYXQgZ290IHZt
YWxsb2MnZWQuIEp1c3QgdXNlIHZtYWxsb2NfdG9fcGFnZSgpDQo+IGFuZCBpdCdzIFJJR0hUIFRI
RVJFLg0KDQpJIHRoaW5rIHRoaXMgd29u4oCZdCB3b3JrLCBhcyBzZXRfbWVtb3J5X3JvIG1ha2Vz
IGFsbCB0aGUgYWxpYXNlcyBvZiANCnRoZXNlIHBhZ2VzIHJlYWQgb25seS4gV2UgY2FuIHByb2Jh
Ymx5IGFkZCBzZXRfbWVtb3J5X3JvX25vYWxpYXMoKSwgDQp3aGljaCB3aWxsIGJlIHNpbWlsYXIg
dG8gc2V0X21lbW9yeV9ucF9ub2FsaWFzKCkuIFRoaXMgYXBwcm9hY2ggd2FzIA0KTkFDS2VkIGJ5
IFBldGVyWzFdLiBTbyB3ZSB3ZW50IHdpdGggdGhlIGJwZl9hcmNoX3RleHRfY29weSBhcHByb2Fj
aC4NCg0KSWYgd2UgY2FuIGxvb3NlbiB0aGUgV15YIHJlcXVpcmVtZW50IGZvciBCUEYgcHJvZ3Jh
bXMsIG90aGVyIHBhcnRzIA0Kb2YgYnBmX3Byb2dfcGFjayBjb3VsZCBhbHNvIGJlIHNpbXBsaWZp
ZWQuIA0KDQpUaGFua3MsDQpTb25nDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRk
ZXYvMjAyMTExMTYwODAwNTEuR1UxNzQ3MDNAd29ya3RvcC5wcm9ncmFtbWluZy5raWNrcy1hc3Mu
bmV0Lw0KDQo+IA0KPiBBdCB3aGljaCBwb2ludCB5b3UganVzdCB1c2UgdGhlIHNhbWUgYnBmX2pp
dF9maWxsX2hvbGUoKSBmdW5jdGlvbiwgYW5kDQo+IHlvdSdyZSBkb25lLg0KPiANCj4gSW4gb3Ro
ZXIgd29yZHMsIGFsbCBvZiB0aGlzIHNlZW1zIGV4Y2Vzc2l2ZWx5IHN0dXBpZGx5IGRvbmUsIGZv
ciBubw0KPiBnb29kIHJlYXNvbi4gIEl0J3Mgb25seSBtYWtpbmcgaXQgbXVjaCB0b28gY29tcGxp
Y2F0ZWQsIGFuZCBqdXN0IG5vdA0KPiBkb2luZyB0aGUgcmlnaHQgdGhpbmcgYXQgYWxsLg0KPiAN
Cj4gICAgICAgICAgICAgICAgTGludXMNCg0K
