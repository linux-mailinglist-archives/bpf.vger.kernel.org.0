Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25A13AB1CC
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 12:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhFQLBt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 07:01:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17136 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231559AbhFQLBs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 07:01:48 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15HArkBR009872;
        Thu, 17 Jun 2021 03:59:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=9QRHK60a9iDGJt4ki3EEThaB5MdR6Qpx4IDhOampffE=;
 b=mkIV8kta2LM5yGWzLcJFxfnFgSvoDNnh86lj9hIrnl5uPhD48DR2ic7x3531T849NyOx
 fTAWD160qIlioc9LOh1BamwldhSi/tb74P4k+MzqkHR5haCmYfTfmOljG2fFTbg6JTVx
 sOohNaQJ+DQEsD1lPrG7dWDVAjmIChuvkyI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 397mfpwqjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Jun 2021 03:59:37 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 03:59:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bong5TDU2Uxv+6evE80NaB26MV7ODPhd3Y7j9g6fGy5euywMjmGLNl/bFyI74lbbzEGe1biYhHb2NrLu/9a+jCOycZWm0cM3VC1MPs+3TlCeXM6Ck8ihw7XRHChoiyZmw9CH0c72ndLPf0QDb2IwL3XU989QqEJ4t/0gPaogY7faEf3oHNzL1St7omxQsrqX3z9ul2RBpvb3/iii262KhrV1Fa3BlDFZUEQFJFNN4fwuoYldHj6R6hq4iqgTWdCgKzzZtlman8JV/gaXH/dwDhw7FaOSqDgbL+6JJFykh9WSwyny1zwJXSdQ5P7H30ka/dvwT8/jIfU8kmOwfdAowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPbp9yoD8FAzOuha/UMUqXc1XQue7JN/euR33e6tsbw=;
 b=nr8vacKKd6HMCit5CIc33znb3gzaZgZ6YCuVbbXa52rhGcxY3UlGmOqmpZhBbBXuqhj9eOshrHIqvTkQw0JGH06AtBMDWnSxdmh+vB8Y5F7y0eV3xmSrDE5uNqFepxryjJGn+Ua1CpvaS+Zc2NKii1nd/5CuOw4zrMo46RlRaSZlyiBZkvMNzDKQBlswfu5aijHjJMmFYT0P4ZcKSbyVoZFyEZlZMhpWmhQMKnMRhqX9s9C9HcrRwHgrXDQZxzz3lwmoxFDcOhUk4plwyUIDhCD1JGqw0AamjydMimDWWA3u7MvBR/YoFbLzoHpDPpSvcDdzwOY4yu6BiDFrLpGR2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from PH0PR15MB4784.namprd15.prod.outlook.com (2603:10b6:510:8d::17)
 by PH0PR15MB4445.namprd15.prod.outlook.com (2603:10b6:510:81::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 10:59:33 +0000
Received: from PH0PR15MB4784.namprd15.prod.outlook.com
 ([fe80::4f6:97d4:ec70:461c]) by PH0PR15MB4784.namprd15.prod.outlook.com
 ([fe80::4f6:97d4:ec70:461c%7]) with mapi id 15.20.4219.026; Thu, 17 Jun 2021
 10:59:33 +0000
From:   Blaise Sanouillet <blez@fb.com>
To:     Yonghong Song <yhs@fb.com>, Carlos Neira <cneirabustos@gmail.com>
CC:     Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>
Subject: Re: Extending bpf_get_ns_current_pid_tgid()
Thread-Topic: Extending bpf_get_ns_current_pid_tgid()
Thread-Index: AQHWuUbDherKhQaNQEqJohDrmteEb6nFNNsAgAAIYACAADbcgIAAZ4vDgABGAoCAACh8gIFQ26aAgAEKhICAAE7EAIAAVSIAgACGW+w=
Date:   Thu, 17 Jun 2021 10:59:33 +0000
Message-ID: <PH0PR15MB47846AB45C045C4B601BBBEDA00E9@PH0PR15MB4784.namprd15.prod.outlook.com>
References: <C71Q73J0Y8S5.3PXMV3YTPDCL7@maharaja>
 <13b5b2dd-bec0-cef2-7304-7e5a09bafb6c@fb.com>
 <MN2PR15MB2991E847DE47A265E71F1BC8A0E60@MN2PR15MB2991.namprd15.prod.outlook.com>
 <CACiB22i6d2skkJJa7uwVRrYy7dtYOxmLgFwzjtieW4BFn2tzLw@mail.gmail.com>
 <9067600b-f340-ec3e-2ce8-d299793c123a@fb.com>
 <CACiB22iU3zk4Row=wAween=rSvHJ7j7M5T2KbyFk38arzEwQpQ@mail.gmail.com>
 <c176cb4f-26d9-28b3-3f6e-628c1a5fa800@fb.com>
 <8b656897-8241-daed-861d-d33beff7934f@gmail.com>,<f4974f3b-ecf1-78a8-026e-f04b17a88c40@fb.com>
In-Reply-To: <f4974f3b-ecf1-78a8-026e-f04b17a88c40@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c092:400::4:1c10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ead610ee-a30f-42e0-462a-08d9317efd87
x-ms-traffictypediagnostic: PH0PR15MB4445:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR15MB4445134B13A9F517FFE66913A00E9@PH0PR15MB4445.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wQvbru50QB0DKAb/S3UdMOzQaoJf5Vc2IvbKkM9iCV+IXvjRzppujd5CRNF/ALBJGXREWZ8RCAcP5N/H7wFOX1qpc9jBVBUWh7FamLDXAwwDXksEHQBc7YEDMipwA77V+Ap61tUi3whB4WtixFjvBNrdoOuYc1TGMffEdoVvRCOm87H2GYxZT12Lw/zyCBZNWTLjo7zVF5ivubZEwrW4UTK7xbfyjZAxeZ0Ad5UAOzyQtlu1TEFEXrSQuB9FJOLdGDu0m7LOL+cMS5phz38JC+XLr9xYObPrIGL+0VGCPqzVNw45/wPdh3bylGB0+k1s7oM6/CGNJnO3kGUBXgOm05wWrP/o0XOARvRpbtxV5jDDzD2RMZ7ELjS9diXneWrflKnUWzGu4pQ44OMASsPCoYFkv3Q8KOp4LS5fCqU4IUx7aFbZS1gv522hLEwMi9/W8s/gDvFV+f6XJQwo91jfHzr20Gt3+b0aS/uz6/lvKqZRPbTaDgJZW2/y8iuYh1giP6zwM9/jqy96LeJmyDxHBnEK7e3a+qrFCbnVNNVd6EGGrDRpVnJBAPcnbfI5YcKOMcSBmhKt5PgsUpvHMBQniir9Qu60HAKQs+yGQi78APvIA3OF3gv1Qexw9kwOXfjnNA8k9cvZF6NBBbpctyE1kXkA/qtDYsKWhCv7/WKrSjlhX7w21rnrt0evrg9fanTqJfx88z3eKRVBtiSco5oPDUWx9Y33otp5qeCvp1OpMcm1YqCXDMaOf0xKEPHEY/1m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB4784.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(2906002)(478600001)(316002)(86362001)(83380400001)(7116003)(5660300002)(52536014)(186003)(7696005)(8936002)(9686003)(55016002)(8676002)(4326008)(6506007)(966005)(91956017)(53546011)(76116006)(66946007)(54906003)(66556008)(64756008)(66446008)(110136005)(66476007)(122000001)(71200400001)(38100700002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RunFc/BwaVULwE2Z2b838rgwZVAdW0vg1roiD1byEAo5B7iO9d/HrRtxvh?=
 =?iso-8859-1?Q?n83KbmRpc94PiO8stEJVM59kS4rU/6p1IbHVdZpLhRbFETjala6iHesR2o?=
 =?iso-8859-1?Q?UCmMiDIqGsbCJrULJSnXT3hMd1beSvhO6JxaDwqXqFCy7m85+zDl4er6Iu?=
 =?iso-8859-1?Q?dsWi8ap7u0KQUhdl5xVWbQHZdJ3Q1avDHnHDPnDps30KFyJr3jlkLjJplC?=
 =?iso-8859-1?Q?FSq+TwfDQ9++vteji235IXVrlx3Sk//ZzxKtZcUVQgDO7fQ3IuaGdX1A20?=
 =?iso-8859-1?Q?9smW07LgjkVMGVQlsvg3chrJ2c68ReBYnvjTId2Dv6gAE/021l7JFKJQ9y?=
 =?iso-8859-1?Q?L28tAc2PwrM2NzJeEBuM350SQtuFxlRTMo9Zo0IWhfFaqmjvhFIq3b5A17?=
 =?iso-8859-1?Q?sUVL+4ykTee8vCOcFZuBcL91OJ/eJGXTOZWcEeFV2CXEyRph8bZS+J3aUv?=
 =?iso-8859-1?Q?itKhvDIyT26pExYVyK8eugKxN5j0cmi+zb3Tpo0f3xDXZeZLqoMVzHSpCT?=
 =?iso-8859-1?Q?RJqqw/JFMZAzZ/R7vPnknbwJ8P7M4BbhFWEJ387PxHrpQWAQmvp2kE366E?=
 =?iso-8859-1?Q?WCMJzwqrAZGW4Oi4YgooacsB9EhHfvDmD4yNrWmNR8Th/gqL+uo0OKDxZq?=
 =?iso-8859-1?Q?LZtCzZoFH9Pvo02eM7eirzS7Alw5PwrRxrcq/bUFudrQNYizVzyTARM4i1?=
 =?iso-8859-1?Q?Gyum9IaINSv+Khmtold5zeT9Oj/U2LCv3sMR0Az8sBUkuqWf5hhze2PqeO?=
 =?iso-8859-1?Q?FyE7OnjpAZdLquOWvClVGF43na9AoZzaGVkKh23mMCLzYmOQ6AuTNaCUZV?=
 =?iso-8859-1?Q?7pckAQ7lvfDIUv0AHJ/bCcIcuq/4O6OtLQsLacyvYoVsrw6GOWUZyR5p2k?=
 =?iso-8859-1?Q?9VuJF25O1W/WSnu9aJJMaK6hd15oBV17ttwEFR/fKZpR3AtbveC1rKBxCE?=
 =?iso-8859-1?Q?BMktJUE23fUFoJVQKjlorqcYtnvZ2tXRNKUbN7YkgY0O01135o7WAZQeuc?=
 =?iso-8859-1?Q?KzTwpWpVrSB0qExi1eg+faTkTWa+TFJNfxRiQTFujYq7sfGFaiu4DVfIgz?=
 =?iso-8859-1?Q?n8wTtZTSWZUEmRO8erxUernr12SU/lWPLOaoVtZuwpm379BBajd6k4T3ac?=
 =?iso-8859-1?Q?xDKqVgz4btBC+Aa4Wgi5WJISqdhwrqlogto6ZIfZ3+ieMlCxcsx2Zl/0Vh?=
 =?iso-8859-1?Q?MrRRvkyo9kqdxqSUlhgX3cEA6e4iU/f8ii2wOyXr+oEbvPYDj2CcASbTsq?=
 =?iso-8859-1?Q?4puxucwxwlCh0OWqZrpGWseMYKnrdHicnW7mpRQ22O1NxvHAqO+MIXNG6y?=
 =?iso-8859-1?Q?al4MO7eU6qBjbxBORUfG1Bb6BGqQPQ+IuPYy5p+s3tev/QDp6HSTN0+v/e?=
 =?iso-8859-1?Q?gRfJdjbqgW2mBuNXWBudTt+hfMqYkIDA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB4784.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead610ee-a30f-42e0-462a-08d9317efd87
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 10:59:33.7363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +w1bX58QeX3VsMC9s8V7hjrqYNN6em8kIP2R2+8Qp+KTSeLFWbCTdAVVMgw2v3Vr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4445
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 782ZJtPq2Eq-PRuNTEjBRuldNHcO43qB
X-Proofpoint-GUID: 782ZJtPq2Eq-PRuNTEjBRuldNHcO43qB
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_05:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170073
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>On 6/16/21 2:44 PM, Carlos Neira wrote:
>> On 6/16/21 1:02 PM, Yonghong Song wrote:
>>>
>>>
>>> On 6/15/21 6:08 PM, carlos antonio neira bustos wrote:
>>>> I'm resuming work on this and would like to know your opinion and=20
>>>> concerns about the following proposal:
>>>>
>>>> - Add=A0 s_dev from=A0 nsfs to ns_common, so now ns_common will have=20
>>>> inode and device to identify the namespace, as in the future=20
>>>> namespaces will need to match against ino and device.
>>>>
>>>> - That will allow us to remove the call to ns_match on because the=20
>>>> values checked are now present in ns_common (ino and dev_t).
>>>
>>> I understand its benefit but I am not 100% sure whether adding s_dev=20
>>> to ns_common will be accepted or not by upstream just because of this.
>>>
>>> Note that if adding s_dev to ns_common, you then need to ensure s_dev
>>> contains valid value for all usages of ns_common, practically all
>>> namespaces, not just nsfs, otherwise people may argument against this
>>> as existing mechanism works and the change brings little value.
>>> If you go this route, please ensure other namespaces can also
>>> take advantage of this field.
>>=20
>> This route seems like a long one, but is the easier solution that I can=
=20
>> think at this moment.I'll read more of the code to have a better=20
>> understanding of the consequences.
>>=20
>>=20
>>>>
>>>> - Add a new helper named=A0 bpf_get_current_pid_tgid_from_ns that will=
=20
>>>> return pid/tgid from the current task if pid ns matches ino and dev=20
>>>> supplied by the user as now both values are in ns_common.
>>>
>>> I think current helper get_ns_current_pid_tgid() can already do this.
>>> Did I miss anything?
>>>
>>=20
>> The problem with get_ns_current_pid_tgid is that device and ino provided=
=20
>> by the user are compared against the current task pid namespace ino but=
=20
>> dev_t as is not part of ns_common is compared with against the current=20
>> nsfs dev_t. So the helper will only return pid/tgid from the current=20
>> namespace but not will be able to do it for a target ns due to this=20
>> limitation.
>
>Okay, I see you want to get tgid/pid for an arbitrary pidns identified
>with (dev, inode). That makes sense as you need both to compare given
>pidns (dev, inode) info. What is your use case? I guess you try to have
>a daemon monitoring selected containers, is that right?

A user-space tracer like bpftrace needs the pid of the traced process in the
tracer's namespace to be able to symbolize the stack traces, for example.
Note that that the tracer and the traced process are not necessarily in the
same pid namespace or container.
For reference, here's our last discussion on this:
	https://lore.kernel.org/bpf/ba5f3c14-8261-af6f-8850-90848963d63a@fb.com/

Thanks,
Blaise

>
>>=20
>>=20
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> On Fri, Nov 13, 2020 at 1:59 PM Yonghong Song <yhs@fb.com=20
>>>> <mailto:yhs@fb.com>> wrote:
>>>>
>>>>
>>>>
>>>> =A0=A0=A0 On 11/13/20 6:34 AM, carlos antonio neira bustos wrote:
>>>> =A0=A0=A0=A0 > Hi Blaise and Daniel,
>>>> =A0=A0=A0=A0 >
>>>> =A0=A0=A0=A0 >
>>>> =A0=A0=A0=A0 > I was following a couple of months ago how bpftrace was=
 going to
>>>> =A0=A0=A0 handle
>>>> =A0=A0=A0=A0 > this situation. I thought this PR
>>>> =A0=A0=A0=A0 > https://github.com/iovisor/bpftrace/pull/1602
>>>> =A0=A0=A0 <https://github.com/iovisor/bpftrace/pull/1602>
>>>> =A0=A0=A0=A0 > <https://github.com/iovisor/bpftrace/pull/1602
>>>> =A0=A0=A0 <https://github.com/iovisor/bpftrace/pull/1602>>=A0was going=
 to be=20
>>>> merged
>>>> =A0=A0=A0=A0 > but just found today that is not working.
>>>> =A0=A0=A0=A0 >
>>>> =A0=A0=A0=A0 > I agree with Yonghong Song on the approach of using the=
 two=20
>>>> helpers
>>>> =A0=A0=A0=A0 > (bpf_get_pid_tgid() and bpf_get_ns_current_pid_tgid()) =
to move
>>>> =A0=A0=A0 forward
>>>> =A0=A0=A0=A0 > on the short term,=A0bpf_get_ns_current_pid_tgid works =
as a
>>>> =A0=A0=A0 replacement
>>>> =A0=A0=A0=A0 > to bpf_get_pid_tgid when you are instrumenting inside a=
=20
>>>> container.
>>>> =A0=A0=A0=A0 >
>>>> =A0=A0=A0=A0 > But the use case described by Blaise is one I would lik=
e to use
>>>> =A0=A0=A0 bpftrace,
>>>> =A0=A0=A0=A0 >
>>>> =A0=A0=A0=A0 > If nobody is against it, I=A0could start working on a n=
ew helper to
>>>> =A0=A0=A0=A0 > address that situation as I need to have bpftrace worki=
ng in that
>>>> =A0=A0=A0 scenario.
>>>>
>>>> =A0=A0=A0 Yes, please. Thanks!
>>>>
>>>> =A0=A0=A0=A0 >
>>>> =A0=A0=A0=A0 > For my understanding of the problem the new helper shou=
ld be=20
>>>> able to
>>>> =A0=A0=A0=A0 > return pid/tgid from a target namespace, is that correc=
t?.
>>>>
>>>> =A0=A0=A0 Yes. This way, the stack trace can correlate to target names=
pace for
>>>> =A0=A0=A0 symbolization purpose.
>>>>
>>>> =A0=A0=A0=A0 >
>>>> =A0=A0=A0=A0 >
>>>> =A0=A0=A0=A0 > Bests
>>>> =A0=A0=A0=A0 >
>>>> =A0=A0=A0=A0 >
>>>> =A0=A0=A0 [...]
>>>>
>>=20
