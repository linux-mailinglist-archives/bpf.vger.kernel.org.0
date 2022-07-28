Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36115842C5
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 17:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiG1PQT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 11:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiG1PQS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 11:16:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7138A48CAD
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 08:16:17 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SA39JN028407
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 08:16:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=3VrH1ovd9C960L82Hkpca5bd3gGGE3KH3uL31c1ITwA=;
 b=B/ie3sTDk14BpFjMwUyvuCsnD7qpu8+t/VN9KlUmuRZEDZc6bwhFTmRnGAS/sTuxgkBv
 u1fcN8mT0dz1UMmt/tZUulZxSltCIFj9CtbxCcjey8enW5MJ2HP1gMC1rBHsj6rPk4ew
 ZQJFS0EcWFLLx+NBk6vAqz0RXR2swkA1Sfw= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hkfsk43a1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 08:16:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjC8mcpqtjhT2lN6CEYFywvX8Jby4Sf1bRHUm6kM1pGKyTCb07TSLvDoR6fbvuG8ljz7r7FJ93p0XzJIYoJzy1FI3MGlCsUnx8d5Tin/iSuhBzO0K/8//JfoyWTrLLQFyU7aWMPMD2t92Wj+Hm11c0fCsnOqOKPHXDGOZpmgfCs2tEMWpQRkYDmxc1uZR+q9NFq0Htb88AKX3+NOYy4cXkjdRGVqRr3by8cS8zMOB2qn//1HkYRJX2NvtKHTfpyMXJdS6obF16iH6xrFTmM35XcqfhqiJGtxc+5ajeAwOGoz99hthR7JAmUURXG8LPUCWM0QUrP7DxRJPb74svJ/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VrH1ovd9C960L82Hkpca5bd3gGGE3KH3uL31c1ITwA=;
 b=jKzTxWUrRJP/ZThVc6hb9cQMFqvjMb7R2MeBXHxCzdvbrSXexzKToAVZFLXfu+gj/ppXanU/xY9HRkOPz1LcrJSmmTYgAWH6BSyGQrVVqKaX4bdaqwhqTbed+eenuMnoTGT5TYRqDcQjvg8r2yy+lfD/XVkl1Dvkx5sFaHNlB7PStTVUExoSpFxq96kEmZltkeEmDnstN95tsRfwL0p5DJ18N2fdhCmFuKnCwcrMTjI1hmEl6FxAbCCfjwHNxSOIDkpsm3okX2kUBVbzGqksyIuSDEDhJCHGTksZrVn4lN48CEuxmI7BpgIBVPSy7DkZ2/e0Bu0YcfIzvaBE+cqKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by BLAPR15MB4067.namprd15.prod.outlook.com (2603:10b6:208:271::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Thu, 28 Jul
 2022 15:16:14 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 15:16:13 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "memxor@gmail.com" <memxor@gmail.com>
CC:     Yonghong Song <yhs@fb.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "olsajiri@gmail.com" <olsajiri@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
Thread-Topic: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
Thread-Index: AQHYoK8StG1Y6n29KUSEV/VSsAjsP62QkM6AgAE54wCAABc7AIABYbAAgAA4cgCAAGyEgA==
Date:   Thu, 28 Jul 2022 15:16:13 +0000
Message-ID: <cb91084ff7b92f06759358323c45c312da9fe029.camel@fb.com>
References: <20220726051713.840431-1-kuifeng@fb.com>
         <20220726051713.840431-2-kuifeng@fb.com> <Yt/aXYiVmGKP282Q@krava>
         <9e6967ec22f410edf7da3dc6e5d7c867431e3a30.camel@fb.com>
         <CAP01T75twVT2ea5Q74viJO+Y9kALbPFw4Yr6hbBfTdok0vAXaw@mail.gmail.com>
         <30a790ad499c9bb4783db91e305ee6546f497ebd.camel@fb.com>
         <CAP01T75=vMUTqpDHjgb_FokmbbG4VpQCUORUavCs0Z3ujT8Obw@mail.gmail.com>
In-Reply-To: <CAP01T75=vMUTqpDHjgb_FokmbbG4VpQCUORUavCs0Z3ujT8Obw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c58c2821-9c34-40fc-68cf-08da70ac1c5b
x-ms-traffictypediagnostic: BLAPR15MB4067:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gkh5tkuNDPiB/hFJhYtDGvZO1lxnm/tqAPrYrh5gFziJw0LIwBcHa9I5YpzxOeyzL9yquTA2U/rTwHiFO82gjwBzOfkOYAUfVYwUsyQdzLqNuRWb4/ChKgvj2BZS3PDAofyasqSrTGzJS0fiKfH3xZGkc0+ffxP7H7+OTvAMzR2glmotl/e2SEKBtH18kp4N2KqXp+BO4pHbY6W5iVTjF0fudZl8nxIcAgLm3Slv1TMJRfwDTgJxe9Yq3ftYQJ+Rgn/NOZjmW1EZhLPmVNLPTfVOudwqYsN5c1E0FiFSctQTQQieDNcO9uo1mcVwrG/68FuLWvbzxzuzJuP1PtKAsBlyB8ibY5dqR1urdvoEehEM07Cymlf6VErw3yILWu/PH5xp+877HrUgUIMM2w7tKaNvmeCRjA4cm/KPRn9hdDrxmepERILFvuioXkHAPSI2ftd/VoAK5dsDIOq8ijYMq72PdcCBhqCk8bo/r8a6v3HSVMmU6gELGKXIOBxLNIZYrclTkjOvc/nKyEXTJnTHeaPrs5uXS6PqfDNWkGxQjD/d4AI5Obsb+JOBRzGn2SXt7963gE6CEPuM7uTwz/En2/iwKXQFlH8ewMRIX/nMQhXEGQ4uD0GTc/dibz1PvkABpaeEOjV0m1reiXFI4CiyzVwvScWPJidl4I5S2vIJSMNlsiKffDh2/oXqdXoJTtyR8vUWTYcMGAcaWD/XgP42YnNlu+27iLjwGgfvBL/OLCYEpI/cjagcRFuhBqtR9L4yuCadZaQJnb8uUnM8Vz2z3FCF6tv8VUJlGguVyGvHaxIfbHMmkD12pzl+BBsToQce
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(4326008)(66446008)(478600001)(6916009)(41300700001)(6486002)(5660300002)(66476007)(36756003)(86362001)(66556008)(186003)(71200400001)(54906003)(316002)(91956017)(64756008)(8936002)(8676002)(2616005)(76116006)(38070700005)(6506007)(83380400001)(66946007)(2906002)(6512007)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1NUdEZrMVIvamdvL3BtUmhOVFRZOVRpNDNlK0FWRi92WE5FTUxhU0NHUEo4?=
 =?utf-8?B?UktpdlI0UW9nSUVxRFRLV3IvWG0rMEtRRStkS3QyNEFnWWM1eXJ6ZUJzYXJJ?=
 =?utf-8?B?UXpuWWdhb0tEc2ROVVRtTWZMZnlveEdUTisyVy9EUUE2VTRTbmdlTERkK2JS?=
 =?utf-8?B?Z2x5cW9JeVVkRHd4eXdJckJ5YWowbTl5UW5mVU54UXJpZTRHbkVPTlplc0J1?=
 =?utf-8?B?SlZUdDRZcjl2dmJPaEpiTWtMUzdYcDBrVzJqUG9CUzhTOVFSeHB0aHN4cE5u?=
 =?utf-8?B?bDJaQ1IrckFiUUpLQjVlWnJXUlBLT3AvWE5pWW1yUXpKeWNDSWFqV29ldEpi?=
 =?utf-8?B?WEl3US82WE1YR2dmeDJKUE5PdnlPbGpyZXJqV1ZBR1JET0xmL2hKNzZESUsx?=
 =?utf-8?B?akNCYXc3Q21DcWNZQW43RnVmQmo5aHVxTnRES2ZJUU94VGxJVXNtTCt6SklI?=
 =?utf-8?B?S29mWnZvem5TOEozazdlQmpjL0dtekliNDhCK1VLSFJxNzhtOFlWMXo3dkQ0?=
 =?utf-8?B?VVhocEk4YnY5SDNUTUpuMnVuNDJsdHR3UTNKQjE3SCsyK0tFTFVINXBaZktK?=
 =?utf-8?B?c2h5MVVEUUN2WTkrUmlMcFZGY3E4V0VxTWUvM3ZJV2pqS0swaWRvWmxCenlX?=
 =?utf-8?B?V0FzY0lENVF4U3NZWXJmTjBJb2plMWI5V1dkc2ErYkRTMlZOYllPMU9VZVBv?=
 =?utf-8?B?VzFQdSt6bW9QM1Q5ckN6Y2JCNjdnWjFIWnVWVTFRcHZwOHBMWngrVkRqWnZ4?=
 =?utf-8?B?Sng3blV6T1ljMWRBR2VPS0k4UmsyZ0hqYkVRd0xpWmdldm1nVStxcFF0dmxD?=
 =?utf-8?B?LzBwd05KZVpKR3N4dXhvWHBOZlF3UnpaMzRzQzNMTWZ6KzZ2VUtJcG14MDhu?=
 =?utf-8?B?dVE5aHhJbllCemZvM3hUbE9QK1hmc0VLZmlZMk9UVDNKZFQ1TzdIUUFuTHRs?=
 =?utf-8?B?VlA4TXRTeDY1aTU1b2dzMFJBSVdLUjZiYWM5d2JyRmVubUpMT3FpaHZoYVdt?=
 =?utf-8?B?WnZ1Z25SUDJaNDRxbWI0TWpsNExxWk9nQjMwbVNjSnJnREJuTU5FOEZGVWVv?=
 =?utf-8?B?MGNOeGYzL1BtVlZsUVE1M0xHa1VKdEduQXZNRWFZOWxQbTFmMHFQK25aNmtD?=
 =?utf-8?B?b0ZEUjNOaktOWmRQT2ozNGU4cmhHVGpaVFpVWHBONi9QTGt1ZysrZnIvY052?=
 =?utf-8?B?U3d0YVgrUFVoZTlHRjdnWFNFWTd1SWlIS3ZCRlFQZkhNd1NiUnFXdi9LTy93?=
 =?utf-8?B?MElnZjExNVdnYlh2dU1yYXZKM0lpRFZJcytFekdYSEF4dnc5a1ZEd1d1YjBH?=
 =?utf-8?B?NEVoRis0TjJ1ZWVJSzR0TGdwRFliUFZidHF2RXNUd1lab1JUVE9jZ2ZpaXBL?=
 =?utf-8?B?MS96RVFtbFByQkV2cHcxanpNaUxQdFFlbENCdzlDMENaMVV1aUNoeXB4cFhU?=
 =?utf-8?B?QzFUejJPcG12ekhBS2dCckFvcEQvOXNxWVM3RFRFVWZRVHkvd1dua09NbXlC?=
 =?utf-8?B?Z1Z4Qmd6cWVOMW9STjRhR21vVG1ySDdDaEFXNDl2UVFCVlNaVmlYZ01yMWZY?=
 =?utf-8?B?WEM5dEU3dDZUalEyNXp5TVl5bFVmdG1WRnVCV1dKOUJMRStYSWxkbnNsVUx3?=
 =?utf-8?B?SU1aZUNmT2Z3ZnFDQ1NRdVBtY29yZEhtOENvSkRKM2lCb05KaEhReFQrd3Ns?=
 =?utf-8?B?QVJtUTdyYWJpL1diRXJCTWdRU1Rwank1ckh6MWhYVU9hc0NLNTdtMnQ2amxN?=
 =?utf-8?B?eVVtdURSdGlMNjBoY3ZLUW1oQzdIVHV5cHA4Ny9aUE5CRWVQQzNMU096NWFO?=
 =?utf-8?B?S245dFdscldJWUxHU3pBN1FpVmZsMk90bWtUcE1QcFErN1V2VGlGb2xseHRi?=
 =?utf-8?B?UncvLzBDWnVwdjM2ek5kdTRXWUM1THB5YTVtOWhBSk1hWGFkZkJjeGxpcE0z?=
 =?utf-8?B?RWxqSElQcDZtc3NLcGhla2pnZFhYYmVyY09odG1veDVGTEFyTExKWjBJNUpE?=
 =?utf-8?B?VWtjQUFvN21kTnFFUXZJMFEwczkzbXg1Zm4rS3c2S0d1SHIxM3hKVnJCVm1h?=
 =?utf-8?B?dENieGlESzNyRFpodEFMY2JGM1YvLys3NkYxZG1rRHQ0SUtNMjJFOTdFeEJW?=
 =?utf-8?B?MUhTZVFuWTVpb21EVFl2ZzlBZWRid2tSNlZDNkJYMFNWTGQyMW10aS8rcGJ0?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <751A4169967D4B44939748160666E007@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58c2821-9c34-40fc-68cf-08da70ac1c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 15:16:13.8472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JuzDsXYpmLX1KOQcE0Gu7UlZ0e2DJPwC5+wvNBNmXyZsY+MwtGrEwoDTC6E8gDKg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB4067
X-Proofpoint-GUID: pHHUbgNGZhZgSI3TTCgUU_PkALd4jFQN
X-Proofpoint-ORIG-GUID: pHHUbgNGZhZgSI3TTCgUU_PkALd4jFQN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIyLTA3LTI4IGF0IDEwOjQ3ICswMjAwLCBLdW1hciBLYXJ0aWtleWEgRHdpdmVk
aSB3cm90ZToNCj4gT24gVGh1LCAyOCBKdWwgMjAyMiBhdCAwNzoyNSwgS3VpLUZlbmcgTGVlIDxr
dWlmZW5nQGZiLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gV2VkLCAyMDIyLTA3LTI3IGF0IDEw
OjE5ICswMjAwLCBLdW1hciBLYXJ0aWtleWEgRHdpdmVkaSB3cm90ZToNCj4gPiA+IE9uIFdlZCwg
MjcgSnVsIDIwMjIgYXQgMDk6MDEsIEt1aS1GZW5nIExlZSA8a3VpZmVuZ0BmYi5jb20+DQo+ID4g
PiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIFR1ZSwgMjAyMi0wNy0yNiBhdCAxNDoxMyAr
MDIwMCwgSmlyaSBPbHNhIHdyb3RlOg0KPiA+ID4gPiA+IE9uIE1vbiwgSnVsIDI1LCAyMDIyIGF0
IDEwOjE3OjExUE0gLTA3MDAsIEt1aS1GZW5nIExlZSB3cm90ZToNCj4gPiA+ID4gPiA+IEFsbG93
IGNyZWF0aW5nIGFuIGl0ZXJhdG9yIHRoYXQgbG9vcHMgdGhyb3VnaCByZXNvdXJjZXMgb2YNCj4g
PiA+ID4gPiA+IG9uZQ0KPiA+ID4gPiA+ID4gdGFzay90aHJlYWQuDQo+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+IFBlb3BsZSBjb3VsZCBvbmx5IGNyZWF0ZSBpdGVyYXRvcnMgdG8gbG9vcCB0aHJv
dWdoIGFsbA0KPiA+ID4gPiA+ID4gcmVzb3VyY2VzIG9mDQo+ID4gPiA+ID4gPiBmaWxlcywgdm1h
LCBhbmQgdGFza3MgaW4gdGhlIHN5c3RlbSwgZXZlbiB0aG91Z2ggdGhleSB3ZXJlDQo+ID4gPiA+
ID4gPiBpbnRlcmVzdGVkDQo+ID4gPiA+ID4gPiBpbiBvbmx5IHRoZSByZXNvdXJjZXMgb2YgYSBz
cGVjaWZpYyB0YXNrIG9yIHByb2Nlc3MuwqANCj4gPiA+ID4gPiA+IFBhc3NpbmcNCj4gPiA+ID4g
PiA+IHRoZQ0KPiA+ID4gPiA+ID4gYWRkaXRpb25hbCBwYXJhbWV0ZXJzLCBwZW9wbGUgY2FuIG5v
dyBjcmVhdGUgYW4gaXRlcmF0b3IgdG8NCj4gPiA+ID4gPiA+IGdvDQo+ID4gPiA+ID4gPiB0aHJv
dWdoIGFsbCByZXNvdXJjZXMgb3Igb25seSB0aGUgcmVzb3VyY2VzIG9mIGEgdGFzay4NCj4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogS3VpLUZlbmcgTGVlIDxrdWlmZW5n
QGZiLmNvbT4NCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gwqBpbmNsdWRlL2xpbnV4L2Jw
Zi5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNCArKw0KPiA+ID4gPiA+ID4gwqBpbmNsdWRl
L3VhcGkvbGludXgvYnBmLmjCoMKgwqDCoMKgwqAgfCAyMyArKysrKysrKysrDQo+ID4gPiA+ID4g
PiDCoGtlcm5lbC9icGYvdGFza19pdGVyLmPCoMKgwqDCoMKgwqDCoMKgIHwgODENCj4gPiA+ID4g
PiA+ICsrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gPiA+ID4gPiAtLS0tDQo+ID4gPiA+
ID4gPiAtLS0tDQo+ID4gPiA+ID4gPiDCoHRvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaCB8
IDIzICsrKysrKysrKysNCj4gPiA+ID4gPiA+IMKgNCBmaWxlcyBjaGFuZ2VkLCAxMDkgaW5zZXJ0
aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L2JwZi5oIGIvaW5jbHVkZS9saW51eC9icGYuaA0KPiA+ID4g
PiA+ID4gaW5kZXggMTE5NTAwMjkyODRmLi5jOGQxNjQ0MDRlMjAgMTAwNjQ0DQo+ID4gPiA+ID4g
PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2JwZi5oDQo+ID4gPiA+ID4gPiArKysgYi9pbmNsdWRlL2xp
bnV4L2JwZi5oDQo+ID4gPiA+ID4gPiBAQCAtMTcxOCw2ICsxNzE4LDEwIEBAIGludCBicGZfb2Jq
X2dldF91c2VyKGNvbnN0IGNoYXINCj4gPiA+ID4gPiA+IF9fdXNlcg0KPiA+ID4gPiA+ID4gKnBh
dGhuYW1lLCBpbnQgZmxhZ3MpOw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiDCoHN0cnVjdCBi
cGZfaXRlcl9hdXhfaW5mbyB7DQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYnBm
X21hcCAqbWFwOw0KPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3Qgew0KPiA+ID4gPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX191MzLCoMKgIHRpZDsNCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBzaG91bGQgYmUganVzdCB1MzIgPw0KPiA+ID4gPiANCj4gPiA+ID4gT3Is
IHNob3VsZCBjaGFuZ2UgdGhlIGZvbGxvd2luZyAndHlwZScgdG8gX191OD8NCj4gPiA+IA0KPiA+
ID4gV291bGQgaXQgYmUgYmV0dGVyIHRvIHVzZSBhIHBpZGZkIGluc3RlYWQgb2YgYSB0aWQgaGVy
ZT8gVW5zZXQNCj4gPiA+IHBpZGZkDQo+ID4gPiB3b3VsZCBtZWFuIGdvaW5nIG92ZXIgYWxsIHRh
c2tzLCBhbmQgYW55IGZkID4gMCBpbXBsaWVzIGF0dGFjaGluZw0KPiA+ID4gdG8NCj4gPiA+IGEN
Cj4gPiA+IHNwZWNpZmljIHRhc2sgKGFzIGlzIHRoZSBjb252ZW50aW9uIGluIEJQRiBsYW5kKS4g
TW9zdCBvZiB0aGUgbmV3DQo+ID4gPiBVQVBJcyB3b3JraW5nIG9uIHByb2Nlc3NlcyBhcmUgdXNp
bmcgcGlkZmRzICh0byB3b3JrIHdpdGggYQ0KPiA+ID4gc3RhYmxlDQo+ID4gPiBoYW5kbGUgaW5z
dGVhZCBvZiBhIHJldXNhYmxlIElEKS4NCj4gPiA+IFRoZSBpdGVyYXRvciB0YWtpbmcgYW4gZmQg
YWxzbyBnaXZlcyBhbiBvcHBvcnR1bml0eSB0byBCUEYgTFNNcw0KPiA+ID4gdG8NCj4gPiA+IGF0
dGFjaCBwZXJtaXNzaW9ucy9wb2xpY2llcyB0byBpdCAob25jZSB3ZSBoYXZlIGEgZmlsZSBsb2Nh
bA0KPiA+ID4gc3RvcmFnZQ0KPiA+ID4gbWFwKSBlLmcuIHdoZXRoZXIgY3JlYXRpbmcgYSB0YXNr
IGl0ZXJhdG9yIGZvciB0aGF0IHNwZWNpZmljDQo+ID4gPiBwaWRmZA0KPiA+ID4gaW5zdGFuY2Ug
KGJhY2tlZCBieSB0aGUgc3RydWN0IGZpbGUpIHdvdWxkIGJlIGFsbG93ZWQgb3Igbm90Lg0KPiA+
ID4gWW91IGFyZSB1c2luZyBnZXRwaWQgaW4gdGhlIHNlbGZ0ZXN0IGFuZCBrZWVwaW5nIHRyYWNr
IG9mDQo+ID4gPiBsYXN0X3RnaWQNCj4gPiA+IGluDQo+ID4gPiB0aGUgaXRlcmF0b3IsIHNvIEkg
Z3Vlc3MgeW91IGRvbid0IGV2ZW4gbmVlZCB0byBleHRlbmQgcGlkZmRfb3Blbg0KPiA+ID4gdG8N
Cj4gPiA+IHdvcmsgb24gdGhyZWFkIElEcyByaWdodCBub3cgZm9yIHlvdXIgdXNlIGNhc2UgKGFu
ZCBmZHRhYmxlIGFuZA0KPiA+ID4gbW0NCj4gPiA+IGFyZQ0KPiA+ID4gc2hhcmVkIGZvciBQT1NJ
WCB0aHJlYWRzIGFueXdheSwgc28gZm9yIHRob3NlIHR3byBpdCB3b24ndCBtYWtlIGENCj4gPiA+
IGRpZmZlcmVuY2UpLg0KPiA+ID4gDQo+ID4gPiBXaGF0IGlzIHlvdXIgb3Bpbmlvbj8NCj4gPiAN
Cj4gPiBEbyB5b3UgbWVhbiByZW1vdmVkIGJvdGggdGlkIGFuZCB0eXBlLCBhbmQgcmVwbGFjZSB0
aGVtIHdpdGggYQ0KPiA+IHBpZGZkPw0KPiA+IFdlIGNhbiBkbyB0aGF0IGluIHVhcGksIHN0cnVj
dCBicGZfbGlua19pbmZvLsKgIEJ1dCwgdGhlIGludGVyYWwNCj4gPiB0eXBlcywNCj4gPiBleC4g
YnBmX2l0ZXJfYXV4X2luZm8sIHN0aWxsIG5lZWQgdG8gdXNlIHRpZCBvciBzdHJ1Y3QgZmlsZSB0
bw0KPiA+IGF2b2lkDQo+ID4gZ2V0dGluZyBmaWxlIGZyb20gdGhlIHBlci1wcm9jZXNzIGZkdGFi
bGUuwqAgSXMgdGhhdCB3aGF0IHlvdSBtZWFuPw0KPiA+IA0KPiANCj4gWWVzLCBqdXN0IGZvciB0
aGUgVUFQSSwgaXQgaXMgc2ltaWxhciB0byB0YWtpbmcgbWFwX2ZkIGZvciBtYXAgaXRlci4NCj4g
SW4gYnBmX2xpbmtfaW5mbyB3ZSBzaG91bGQgcmVwb3J0IGp1c3QgdGhlIHRpZCwganVzdCBsaWtl
IG1hcCBpdGVyDQo+IHJlcG9ydHMgbWFwX2lkLg0KDQpJdCBzb3VuZHMgZ29vZCB0byBtZS4NCg0K
T25lIHRoaW5nIEkgbmVlZCBhIGNsYXJpZmljYXRpb24uIFlvdSBtZW50aW9uZWQgdGhhdCBhIGZk
ID4gMCBpbXBsaWVzDQphdHRhY2hpbmcgdG8gYSBzcGVjaWZpYyB0YXNrLCBob3dldmVyIGZkIGNh
biBiZSAwLiBTbywgaXQgc2hvdWxkIGJlIGZkDQo+PSAwLiBTbywgaXQgZm9yY2VzIHRoZSB1c2Vy
IHRvIGluaXRpYWxpemUgdGhlIHZhbHVlIG9mIHBpZGZkIHRvIC0xLiANClNvLCBmb3IgY29udmVu
aWVuY2UsIHdlIHN0aWxsIG5lZWQgYSBmaWVsZCBsaWtlICd0eXBlJyB0byBtYWtlIGl0IGVhc3kN
CnRvIGNyZWF0ZSBpdGVyYXRvcnMgd2l0aG91dCBhIGZpbHRlci4NCg0KDQo=
